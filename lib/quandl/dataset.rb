module Quandl
  class Dataset < Quandl::Base
    include Quandl::Filter

    def reload!
      raw_data = Quandl::Request.new('datasets', {
        dataset: query,
        options: options
      }).get
      response = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      @data = response.delete(:data)
      @metadata = response
      self
    end
  end
end