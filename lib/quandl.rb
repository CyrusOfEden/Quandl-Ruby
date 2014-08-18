require 'quandl/version'
require 'open-uri'

module Quandl
  API_URI = 'http://www.quandl.com/api/'

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

  def self.build_uri(params)
    path = [configuration.api_version, 'datasets']
    if configuration.auth_token
      params[:auth_token] = configuration.auth_token
    end
    unless params[:query]
      path << params.delete(:source)
      path << params.delete(:table)
    end
    path = path.join('/') + '.' + (params[:options][:format] || 'json')
    URI(API_URI + path).tap do |uri|
      uri.query = URI.encode_www_form(params[:options])
    end
  end

  def self.get(params = {})
    open(build_uri(params)).read
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
    attr_accessor :source, :table, :options
    def initialize(params = {}, options = {})
      if params.is_a? String
        match_data = params.match(/(.+)\/(.+)/)
        params = {
          source: match_data[1],
          table:  match_data[2]
        }
      end
      @source  = params[:source].upcase
      @table   = params[:table].upcase
      @options = options
    end

    def get
      data = Quandl.get(source: source, table: table, options: options)
      if block_given?
        yield(data)
      else
        data
      end
    end
  end

  class Metadata < Dataset
    def initialize(params = {}, options = {})
      options[:exclude_data] = true
      super
    end
  end

  class Search
    attr_accessor :query, :options
    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def get
      data = Quandl.get(query: query, options: options)
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
