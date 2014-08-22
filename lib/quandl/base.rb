module Quandl
  class Base
    attr_accessor :query, :options

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
  end
end
