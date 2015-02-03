# TODO: Refactoring

class Resterl::PutRequest < Resterl::GenericRequest
  def initialize client, url, query_params, data, headers
    super client, url, query_params, headers
    @data = data
  end
  def perform
    http, path = http_object_and_query_path
    request = Net::HTTP::Put.new path, @headers
    apply_basic_auth request
    request.body = @data
    self.response = http.request(request)

    self
  end

end
