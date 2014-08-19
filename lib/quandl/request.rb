module Quandl
  API_URI = 'http://www.quandl.com/api/'

  def self.build_uri(params, override = nil)
    path = [configuration.api_version, 'datasets']
    if configuration.auth_token
      params[:auth_token] = configuration.auth_token
    end
    unless params[:query]
      path << params.delete(:source)
      path << params.delete(:table)
    end
    path = path.join('/') + '.' + (params[:options][:format] || 'json')
    URI(API_URI + path).tap do |uri|
      uri.query = URI.encode_www_form(params[:options])
    end
  end

  def self.get(params = {})
    open(build_uri(params)).read
  end
end
