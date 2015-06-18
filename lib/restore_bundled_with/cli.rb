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
  end
end
