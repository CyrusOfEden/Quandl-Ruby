module Quandl
  class Search
    attr_accessor :query, :options, :data

    def self.get(query, options = {})
      instance = new(query, options)
      instance.get
      if block_given?
        yield(instance.data)
      else
        instance.data
      end
    end

    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def get
      if !data || reload
        raw_data = Quandl::Request.new('datasets', {
          query: query,
          options: options
        }).get
        self.data = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      end
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
