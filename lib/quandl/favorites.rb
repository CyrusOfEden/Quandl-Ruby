module Quandl
  class Favorites
    attr_reader :auth_token, :options

    def self.get(options = {})
      new(options).get
    end

    def initialize(options = {})
      @auth_token = options.delete(:auth_token) || Quandl.configuration.auth_token
      @options = options
    end

    def get
      data = Quandl::Request.new('current_user/collections/datasets/favourites', {
        options: options,
        auth_token: auth_token
      }).get
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
