require 'git'
require 'logger'

require 'restore_bundled_with/error'
require 'restore_bundled_with/lock'
require 'restore_bundled_with/repository'
require 'restore_bundled_with/version'

# Restore BUNDLED WITH section in Gemfile.lock from git repository.
module RestoreBundledWith
  ISSUE_URL = 'https://github.com/packsaddle/ruby-restore_bundled_with/issues/new'.freeze
  def self.default_logger
    logger = Logger.new(STDERR)
    logger.progname = "RestoreBundledWith #{VERSION}"
    logger.level = Logger::WARN
    logger
  end

  def self.logger
    return @logger if @logger
    @logger = default_logger
  end

  class << self
    attr_writer :logger
  end
end
