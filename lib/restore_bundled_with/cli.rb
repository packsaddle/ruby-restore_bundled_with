require 'thor'

module RestoreBundledWith
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Show the RestoreBundledWith version'
    map %w(-v --version) => :version

    def version
      puts "RestoreBundledWith version #{::RestoreBundledWith::VERSION}"
    end

    desc 'restore', 'Restore BUNDLED WITH on Gemfile.lock'
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    option :lockfile, type: :string, default: Fetch::LOCK_FILE
    def restore
      setup_logger(options)
    rescue StandardError => e
      suggest_messages(options)
      raise e
    end

    desc 'trim', 'Trim BUNDLED WITH'
    option :data
    option :file
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def trim
      setup_logger(options)

      data = read_data(options)
      puts data
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
