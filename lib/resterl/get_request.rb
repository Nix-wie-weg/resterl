# Redirect code from:
# http://railstips.org/blog/archives/2009/03/04/following-redirects-with-nethttp/
class Resterl::GetRequest < Resterl::GenericRequest
  attr_accessor :redirect_limit

  def initialize client, url, query_params, headers
    super client, url, query_params, headers
    @redirect_limit = @rest_client.options[:max_redirect_depth]
  end

  def perform
    raise TooManyRedirects if redirect_limit < 0

    http, path = get_http_object_and_query_path
    request = Net::HTTP::Get.new path, @headers
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

end
