module Quandl
  module Filter
    def rows(n)
      @options[:rows] = n
      self
    end

    def order(direction)
      @options[:sort_order] = direction if [:asc, :desc].include? direction
      self
    end

    def column(n)
      @options[:column] = n
      self
    end

    def collapse(frequency)
      if [:none, :daily, :weekly, :monthly, :quarterly, :annual].include? frequency
        @options[:collapse] = frequency
      end
      self
    end

    def transform(transformation)
      if [:diff, :rdiff, :cumul, :normalize].include? transformation
        @options[:transformation] = transformation
      end
      self
    end

    def headers(request)
      @options[:exclude_headers] = !request
      self
    end

    [:start, :end].each do |filter|
      define_method(filter) do |datetime|
        if datetime.is_a?(String) && match_data = datetime.match(/(\d{4}).(\d{2}).(\d{2})/)
          @options["trim_#{filter}".to_sym] = match_data[1..3].join('-')
        elsif datetime.is_a?(Date)
          @options["trim_#{filter}".to_sym] = datetime.to_s
        end
        self
      end
    end
  end
end
