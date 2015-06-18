require 'logger'

require 'restore_bundled_with/version'

module RestoreBundledWith
  def self.default_logger
    logger = Logger.new(STDERR)
    logger.progname = 'RestoreBundledWith'
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
