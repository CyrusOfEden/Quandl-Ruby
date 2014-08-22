module Quandl
  class Favorites < Quandl::Dataset
    def initialize(options = {})
      @query = options.delete(:auth_token) || Quandl.configuration.auth_token
      @options = options
    end

    def reload!
      raw_data = Quandl::Request.new('current_user/collections/datasets/favourites', {
        auth_token: query,
        options: options
      }).get
      response = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      @data = response.delete(:data)
      @metadata = response
    end
  end

  Favourites = Favorites
end
