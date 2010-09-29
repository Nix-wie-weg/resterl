# Redirect code from:
# http://railstips.org/blog/archives/2009/03/04/following-redirects-with-nethttp/
class Resterl::Request
  attr_accessor :rest_client, :url, :body, :redirect_limit, :response
  DEFAULT_HEADERS = {}

  def initialize client, url, query_params, headers
    @rest_client = client
    @url = url
    @query_params = query_params
    @redirect_limit = @rest_client.options[:max_redirect_depth]
    @headers = DEFAULT_HEADERS.merge headers
  end
  def perform
    raise TooManyRedirects if redirect_limit < 0

    # build URL
    #complete_url = url.dup
    #complete_url << "?#{query_param_string}" unless query_param_string.blank?
    #puts complete_url
    uri = URI.parse(url)#complete_url)
    #puts uri.path


    http = Net::HTTP.new(uri.host, uri.port)
    apply_ssl http, uri

    path_with_query = uri.path
    path_with_query << "?#{query_param_string}" unless query_param_string.blank?
    request = Net::HTTP::Get.new path_with_query, @headers
    apply_basic_auth request
    self.response = http.request(request)

    # Follow redirects
    if response.is_a?(Net::HTTPRedirection) &&
       !response.is_a?(Net::HTTPNotModified)
      self.url = redirect_url
      self.redirect_limit -= 1
      perform
    end
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
