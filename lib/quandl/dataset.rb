module Quandl
  class Dataset
    attr_accessor :source, :table, :options
    def initialize(params = '', options = {})
      match_data = params.match(/(.+)\/(.+)/)
      @source = match_data[1].upcase,
      @table = match_data[2].upcase
      @options = options
    end

    def get
      data = Quandl::Request.new.get(source: source, table: table, options: options)
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end