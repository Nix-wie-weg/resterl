class Resterl::Response
  attr_reader :body, :expires_at, :net_http_response

  def initialize(r)
    @net_http_response = r
    @body = r.body
    #@expires_in = extract_max_age
    @expires_at = Time.now + extract_max_age
  end

  def expired?
    @expires_at < Time.now
  end

  def update_expires_at t
    @expires_at = t
  end

  private
  
  def extract_max_age
    cc = @net_http_response['Cache-Control']
    cc.is_a?(String) ? cc[/max-age=(\d+)/, 1].to_i : 0
  end
end
