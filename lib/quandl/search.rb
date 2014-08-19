module Quandl
  class Search
    attr_accessor :query, :options
    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def get
      data = Quandl::Request.new('datasets', {
        query: query,
        options: options
      }).get
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
