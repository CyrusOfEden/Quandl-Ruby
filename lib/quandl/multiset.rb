module Quandl
  class Multiset
    attr_accessor :sets, :options, :data

    def self.get(datasets, options = {})
      instance = new(datasets, options)
      instance.get
      if block_given?
        yield(instance.data)
      else
        instance.data
      end
    end

    def initialize(datasets, options = {})
      @sets = datasets
      @options = options
    end

    def get
      if !data || reload
        self.data = Quandl::Request.new('multisets', {
          datasets: sets,
          options: options
        }).get
      end
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end
