require 'thor'

module RestoreBundledWith
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Show the RestoreBundledWith version'
    map %w(-v --version) => :version
    option :digit, type: :boolean, default: false
    def version
      if options[:digit]
        print ::RestoreBundledWith::VERSION
      else
        puts "RestoreBundledWith version #{::RestoreBundledWith::VERSION}"
      end
    end

    desc 'restore', 'Restore BUNDLED WITH on Gemfile.lock'
    option :data
    option :file
    option :lockfile, type: :string, default: Repository::LOCK_FILE
    option :ref, type: :string, default: Repository::REF
    option :git_path, type: :string, default: Repository::GIT_PATH
    option :git_options, type: :hash, default: Repository::GIT_OPTIONS
    option :new_line, type: :string, default: Repository::NEW_LINE
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def restore
      setup_logger(options)

      params = options.dup
      params[:file] = options[:lockfile] if !options[:data] && !options[:file]
      data = read_data(params)
      lock_file = Lock.restore(
        data,
        options[:lockfile],
        options[:ref],
        options[:git_path],
        options[:git_options],
        options[:new_line]
      )
      lock_file.write_to(options[:lockfile])
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end
    default_command :restore

    desc 'delete', 'Delete BUNDLED WITH'
    option :data
    option :file
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def delete
      setup_logger(options)

      data = read_data(options)
      puts Lock.new(data).delete_bundled_with
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end

    desc 'fetch', 'Fetch BUNDLED WITH section'
    option :lockfile, type: :string, default: Repository::LOCK_FILE
    option :ref, type: :string, default: Repository::REF
    option :git_path, type: :string, default: Repository::GIT_PATH
    option :git_options, type: :hash, default: Repository::GIT_OPTIONS
    option :new_line, type: :string, default: Repository::NEW_LINE
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def fetch
      setup_logger(options)
      lock_file = Repository
                  .new(options[:git_path], options[:git_options])
                  .fetch_file(
                    options[:lockfile],
                    options[:ref],
                    options[:new_line])
      puts Lock
        .new(lock_file)
        .pick
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end

    no_commands do
      def read_data(options)
        data = \
          if options[:data]
            options[:data]
          elsif options[:file]
            File.read(options[:file])
          elsif !$stdin.tty?
            ARGV.clear
            ARGF.read
          end

        logger.info('input data')
        logger.info(data)
        fail NoInputError if !data || data.empty?

        data
      end

      def logger
        ::RestoreBundledWith.logger
      end

      def setup_logger(options)
        if options[:debug]
          logger.level = Logger::DEBUG
        elsif options[:verbose]
          logger.level = Logger::INFO
        end
        logger.debug(options)
      end

      def suggest_messages(options)
        logger.error 'Please report from here:'
        logger.error ISSUE_URL
        logger.error 'options:'
        logger.error options
      end

      # http://stackoverflow.com/a/23955971/104080
      def method_missing(method, *args)
        self.class.start([self.class.default_command, method.to_s] + args)
      end
    end
  end
end
