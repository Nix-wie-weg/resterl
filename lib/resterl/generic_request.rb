class Resterl::GenericRequest
  attr_accessor :rest_client, :url, :body, :response
  DEFAULT_HEADERS = {}
  
  def initialize client, url, query_params, headers
    @rest_client = client
    @url = url
    @query_params = query_params
    @headers = DEFAULT_HEADERS.merge headers
  end
    
  private
  
  def get_http_object_and_query_path
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    apply_ssl http, uri
    
    path_with_query = uri.path
    path_with_query << "?#{query_param_string}" unless query_param_string.blank?
    
    [http, path_with_query]
  end
  
  def query_param_string
    @query_param_string ||= begin
      @query_params.collect do |key, value|
        "#{URI.escape(key.to_s)}=#{URI.escape(value.to_s)}"
      end.join('&')
    end
  end
  def apply_basic_auth request
    ba = rest_client.options[:basic_auth]
    request.basic_auth(ba[:username], ba[:password]) if ba
  end
  def apply_ssl http, uri
    if uri.is_a? URI::HTTPS
      http.use_ssl = true
      http.verify_mode = rest_client.options[:ssl_verify_mode]
    end
  end
  def redirect_url
    response['location'] || response.body.match(/<a href=\"([^>]+)\">/i)[1]
  end  
end
