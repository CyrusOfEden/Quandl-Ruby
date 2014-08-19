module Quandl
  class Search
    attr_accessor :query, :options
    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def get
      data = Quandl::Request.new.get(query: query, options: options)
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
