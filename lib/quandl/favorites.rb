module Quandl
  class Favorites
    attr_reader :auth_token, :options
    def initialize(auth_token = nil, options = {})
      @auth_token = auth_token || Quandl.configuration.auth_token
      @options = options
    end

    def get
      path = [Quandl.configuration.api_version, 'current_user', 'collections', 'datasets', 'favourites']
      path = path.join('/') + '.' + (options[:format] || 'json')
      uri = URI(Quandl::API_URI + path)
      uri.query = URI.encode_www_form(auth_token: auth_token)
      data = open(uri).read
      if block_given?
        yield data
      else
        data
      end
    end
  end
end
