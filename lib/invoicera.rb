
module Invoicera
  # The exception class from which all Invoicera exceptions inherit.
  class Error < StandardError
    def set_message message
      @message = message
    end

    # @return [String]
    def to_s
      defined? @message and @message or super
    end
  end

  # This exception is raised if Invoicera has not been configured.
  class ConfigurationError < Error
  end

  class << self
    # @return [String] An API key.
    # @raise [ConfigurationError] If not configured.
    def api_key
      defined? @api_key and @api_key or raise(
        ConfigurationError, "Invoicera.api_key not configured"
      )
    end
    attr_writer :api_key

    # @return [String, nil] A default currency.
    def default_currency
      return @default_currency if defined? @default_currency
      @default_currency = 'USD'
    end
    attr_writer :default_currency

    # Assigns a logger to log requests/responses and more.
    #
    # @return [Logger, nil]
    # @example
    #   require 'logger'
    #   Invoicera.logger = Logger.new STDOUT
    # @example Rails applications automatically log to the Rails log:
    #   Invoicera.logger = Rails.logger
    # @example Turn off logging entirely:
    #   Invoicera.logger = nil # Or Invoicera.logger = Logger.new nil
    attr_accessor :logger

    # Convenience logging method includes a Logger#progname dynamically.
    # @return [true, nil]
    def log level, message
      logger.send(level, name) { message }
    end

    if RUBY_VERSION <= "1.9.0"
      def const_defined? sym, inherit = false
        raise ArgumentError, "inherit must be false" if inherit
        super sym
      end

      def const_get sym, inherit = false
        raise ArgumentError, "inherit must be false" if inherit
        super sym
      end
    end
  end
end

require 'rails/invoicera' if defined? Rails::Railtie