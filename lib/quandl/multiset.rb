module Quandl
  class Multiset < Quandl::Dataset
    def get
      if !@data || reload
        raw_data = Quandl::Request.new('multisets', {
          datasets: sets,
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
