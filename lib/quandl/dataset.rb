module Quandl
  class Dataset
    attr_accessor :source, :table, :options
    def initialize(params = {}, options = {})
      if params.is_a? String
        match_data = params.match(/(.+)\/(.+)/)
        params = {
          source: match_data[1],
          table:  match_data[2]
        }
      end
      @source  = params[:source].upcase
      @table   = params[:table].upcase
      @options = options
    end

    def get
      data = Quandl.get(source: source, table: table, options: options)
      if block_given?
        yield(data)
      else
        data
      end
    end
  end
end