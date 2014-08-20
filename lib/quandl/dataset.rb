module Quandl
  class Dataset
    attr_accessor :set, :options, :data

    def self.get(params, options = {})
      instance = new(params, options)
      instance.get
      if block_given?
        yield(instance.data)
      else
        instance.data
      end
    end

    def initialize(params, options = {})
      @set = params
      @options = options
    end

    def get(reload = false)
      if !data || reload
        raw_data = Quandl::Request.new('datasets', {
          dataset: set,
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