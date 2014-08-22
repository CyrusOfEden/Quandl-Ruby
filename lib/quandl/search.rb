module Quandl
  class Search < Quandl::Dataset
    def reload
      raw_data = Quandl::Request.new('datasets', {
        query: query,
        options: options
      }).get
      response = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      @data = response.delete(:data)
      @metadata = response
    end
  end
end
