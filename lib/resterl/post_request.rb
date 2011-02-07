# Redirect code from:
# http://railstips.org/blog/archives/2009/03/04/following-redirects-with-nethttp/

# TODO: Refactoring, zu viel Code?

class Resterl::PostRequest
  attr_accessor :rest_client, :url, :body, :redirect_limit, :response
  DEFAULT_HEADERS = {}

  def initialize client, url, query_params, data, headers
    @rest_client = client
    @url = url
    @query_params = query_params
    @redirect_limit = @rest_client.options[:max_redirect_depth]
    @data = data
    @headers = DEFAULT_HEADERS.merge headers
  end
  def perform
    uri = URI.parse(url)#complete_url)

    http = Net::HTTP.new(uri.host, uri.port)
    apply_ssl http, uri

    path_with_query = uri.path
    path_with_query << "?#{query_param_string}" unless query_param_string.blank?
    request = Net::HTTP::Post.new path_with_query, @headers
    apply_basic_auth request
    request.body = @data
    self.response = http.request(request)

    self
  end

  private

  def query_param_string
    @query_param_string ||= begin
      @query_params.collect do |key, value|
        "#{URI.escape(key.to_s)}=#{URI.escape(value.to_s)}"
      end.join('&')
    end
  end

  def redirect_url
    if response['location'].nil?
      response.body.match(/<a href=\"([^>]+)\">/i)[1]
    else
      response['location']
    end
  end

  def apply_ssl http, uri
    if uri.is_a? URI::HTTPS
      http.use_ssl = true
      http.verify_mode = rest_client.options[:ssl_verify_mode]
    end
  end
  def apply_basic_auth request
    ba = rest_client.options[:basic_auth]
    request.basic_auth(ba[:username], ba[:password]) if ba
  end
end
