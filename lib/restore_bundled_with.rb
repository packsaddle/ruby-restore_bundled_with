require 'logger'

require 'restore_bundled_with/error'
require 'restore_bundled_with/fetch'
require 'restore_bundled_with/trim'
require 'restore_bundled_with/version'

module RestoreBundledWith
  ISSUE_URL = 'https://github.com/packsaddle/ruby-restore_bundled_with/issues/new'
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
