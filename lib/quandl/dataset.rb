module Quandl
  class Dataset
    attr_accessor :query, :options

    include Quandl::Filter

    def self.get(*params)
      new(*params)
    end

    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def value(reload = false)
      if !@data || reload
        raw_data = Quandl::Request.new('datasets', {
          dataset: query,
          options: options
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
end