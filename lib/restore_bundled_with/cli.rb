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
    option :lockfile, type: :string, default: Fetch::LOCK_FILE
    option :ref, type: :string, default: Fetch::REF
    option :git_path, type: :string, default: Fetch::GIT_PATH
    option :git_options, type: :hash, default: Fetch::GIT_OPTIONS
    option :new_line, type: :string, default: Insert::NEW_LINE
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def restore
      setup_logger(options)

      params = options
      params[:file] = options[:lockfile] if !options[:data] && !options[:file]
      data = read_data(params)
      lockfile = Restore.new(
        data,
        options[:lockfile],
        options[:ref],
        options[:git_path],
        options[:git_options],
        options[:new_line]
      )
      lockfile.restore
      lockfile.write
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end

    desc 'delete', 'Delete BUNDLED WITH'
    option :data
    option :file
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def delete
      setup_logger(options)

      data = read_data(options)
      puts Delete.new(data).delete
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end

    desc 'fetch', 'Fetch BUNDLED WITH section'
    option :lockfile, type: :string, default: Fetch::LOCK_FILE
    option :ref, type: :string, default: Fetch::REF
    option :git_path, type: :string, default: Fetch::GIT_PATH
    option :git_options, type: :hash, default: Fetch::GIT_OPTIONS
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def fetch
      setup_logger(options)

      puts Fetch
        .new(
          options[:lockfile],
          options[:ref],
          options[:git_path],
          options[:git_options])
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
    end
  end
end
