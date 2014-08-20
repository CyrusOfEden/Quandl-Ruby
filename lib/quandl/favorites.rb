module Quandl
  class Favorites < Quandl::Dataset
    def initialize(options = {})
      @query = options.delete(:auth_token) || Quandl.configuration.auth_token
      @options = options
    end

    def get(reload = false)
      if !@data || reload
        raw_data = Quandl::Request.new('current_user/collections/datasets/favourites', {
          options: options,
          auth_token: query
        }).get
        @data = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      end
      if block_given?
        yield(@data)
      else
        @data
      end
    end
  end

  Favourites = Favorites
end
