module Quandl
  class Metadata < Quandl::Dataset
    def initialize(query, options = {})
      options[:exclude_data] = true
      super
    end
  end
end
