# TODO: Refactoring

class Resterl::DeleteRequest < Resterl::GenericRequest
  def initialize client, url, query_params, data, headers
    super client, url, query_params, headers
    @data = data
  end
  def perform
    http, path = get_http_object_and_query_path
    request = Net::HTTP::Delete.new path, @headers
    apply_basic_auth request
    self.response = http.request(request)

    self
  end

end