module Quandl
  class Search < Quandl::Base
    [:page, :per_page].each do |filter|
      define_method(filter) do |n|
        @options[filter] = n.to_i
        self
      end
    end

    def reload!
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
