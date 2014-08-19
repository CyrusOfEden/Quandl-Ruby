module Quandl
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
    attr_writer :api_version
    attr_accessor :auth_token

    def initialize
      self.api_version = 1
    end

    def api_version
      "v#{@api_version}"
    end
  end
end
