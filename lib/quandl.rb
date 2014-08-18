require 'quandl/version'

module Quandl
  # Enable configuration like:
  #   Quandl.configure do |q|
  #     ...
  #   end
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :auth_token, :api_version

    def initialize
      @api_version ||= 1
    end
  end
end
