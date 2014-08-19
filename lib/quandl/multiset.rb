module Quandl
  class Multiset
    attr_accessor :datasets, :options
    def initialize(datasets, options = {})
      @datasets = datasets
      @options = options
    end

    def get
      data = Quandl::Request.new('multisets', {
        datasets: datasets,
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
