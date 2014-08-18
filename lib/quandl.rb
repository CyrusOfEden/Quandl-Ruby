require 'quandl/version'
require 'open-uri'

module Quandl
  QUANDL_URI = 'http://www.quandl.com/api'

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

  def self.build_uri(source, table, format, params)
    uri = URI([QUANDLE_URI, configuration.api_version, 'datasets', source, table].join('/') + ".#{format}")
    if configuration.auth_token
      params[:auth_token] = configuration.auth_token
    end
    uri.query = URI.encode_www_form(params)
    uri
  end

  def self.get(params = {})
    yield build_uri(params[:source], params[:table], params[:format], params[:options]).open
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

  class Dataset
    attr_reader :source, :table, :format, :options

    def initialize(params = {})
      @source = params[:source]
      @table = params[:table]
      @format = params[:format] || 'json'
      @options = params[:options] || {}
    end

    def get
      Quandl.get(
        source: source,
        table: table,
        format: format,
        options: options
      )
    end
  end

  class Metadata < Dataset
    def initialize(params = {})
      super
      @options[:exclude_data] = true
    end
  end
end
