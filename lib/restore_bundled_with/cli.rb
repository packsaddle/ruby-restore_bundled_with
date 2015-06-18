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

    no_commands do
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
