module Quandl
  API_URI = 'http://www.quandl.com/api/'

  class Request
    attr_accessor :uri
    def initialize(params)
      path = [configuration.api_version, 'datasets']
      if configuration.auth_token
        params[:auth_token] = configuration.auth_token
      end
      unless params[:query]
        path << params.delete(:source)
        path << params.delete(:table)
      end
      path = path.join('/') + '.' + (params[:options][:format] || 'json')
      @uri = URI(API_URI + path).tap do |uri|
        uri.query = URI.encode_www_form(params[:options])
      end
    end

    def get
      open(uri).read
    end
  end
end
