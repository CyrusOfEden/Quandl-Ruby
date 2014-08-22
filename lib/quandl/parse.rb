require 'json'
require 'csv'

module Quandl
  CSV::Converters[:blank_to_nil] = Proc.new do |field|
    field && field.empty? ? nil : field
  end
  def self.parse(data, format)
    case format
    when :json
      JSON.parse(data, {
        symbolize_names: true
      })
    when :csv
      CSV.parse(data, {
        headers: true,
        header_converters: :symbol,
        converters: [:all, :blank_to_nil]
      }).map(&:to_hash)
    else data
    end
  end
end
