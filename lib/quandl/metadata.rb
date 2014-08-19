module Quandl
  class Metadata < Quandl::Dataset
    def initialize(params = {}, options = {})
      options[:exclude_data] = true
      super
    end
  end
end
