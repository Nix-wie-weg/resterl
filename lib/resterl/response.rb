module Resterl
  class Response
    attr_reader :body, :expires_at, :net_http_response

    def initialize(r, minimum_cache_lifetime)
      @net_http_response = r
      @body = r.body
      @expires_at = Time.now + [extract_max_age, minimum_cache_lifetime].max
    end

    def expired?
      @expires_at < Time.now
    end

    # rubocop:disable Style/TrivialAccessors
    def update_expires_at t
      @expires_at = t
    end
    # rubocop:enable Style/TrivialAccessors

    def header h
      @net_http_response[h]
    end

    def expires_in
      extract_max_age
    end

    private

    def extract_max_age
      cc = @net_http_response['Cache-Control']
      cc.is_a?(String) ? cc[/max-age=(\d+)/, 1].to_i : 0
    end
  end
end
