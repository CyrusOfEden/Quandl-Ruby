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

    [:data, :metadata].each do |data|
      define_method(data) do |bust_cache = false|
        cache = instance_variable_get "@#{data}"
        if cache && !bust_cache
          cache
        else
          reload!
          instance_variable_get "@#{data}"
        end
      end
    end

    def reload!
      raw_data = Quandl::Request.new('datasets', {
        dataset: query,
        options: options
      }).get
      response = Quandl.parse(raw_data, (options[:format] || :json).to_sym)
      @data = response.delete(:data)
      @metadata = response
    end
  end
end