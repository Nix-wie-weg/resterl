class Resterl::Client
  attr_reader :options
  DEFAULTS = {
    :max_redirect_depth => 10,
    :cache => Resterl::Caches::SimpleCache.new,
    :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
    :expiry_multiplier => 10,
    :minimum_cache_lifetime => 5 * 60 # 5 Minuten
  }

  class TooManyRedirects < StandardError; end

  def initialize(options = {})
    @options = DEFAULTS.merge(options).freeze
    @cache = @options[:cache]
  end

  def get url, params, headers
    url = setup_url(url)

    # Cache-Schlüssel aus Pfad hashen
    cache_key = data_to_cache_key url, params, headers

    # Response aus Cache holen
    old_response = @cache.read(cache_key)

    if old_response and not old_response.expired?
      # Anfrage noch nicht abgelaufen, Ergebnis aus dem Cache verwenden
      old_response
    else
      # Neue Anfrage
      new_get_request url, cache_key, params, headers, old_response
    end
  end
  
  def post url, params, data, headers
    # Caching nicht notwendig
    url = setup_url url
    request = Resterl::PostRequest.new(self, url, params, data, headers)
    response = request.perform.response

    response
  end

  private

  def new_get_request url, cache_key, params, headers, old_response

    # Ggf. ETag und Last-Modified auslesen
    if old_response
      etag = old_response.net_http_response['ETag']
      headers['If-None-Match'] = etag if etag

      last_modified = old_response.net_http_response['Last-Modified']
      headers['If-Modified-Since'] = last_modified if last_modified
    end

    # Anfrage stellen, ggf. ETag mit übergeben
    request = Resterl::GetRequest.new(self, url, params, headers)
    new_response = request.perform.response

    response, max_age_seconds = case new_response

    when Net::HTTPClientError, Net::HTTPServerError
      # Aus dem Cache muss nichts entfernt werden, weil ja auch kein Eintrag
      # (mehr) drin ist.
      new_response.error!

    when Net::HTTPNotModified
      # Wenn "304 Not Modified", dann altes Ergebnis als neues Ergebnis
      # verwenden
      r_temp = Resterl::Response.new(new_response)
      old_response.update_expires_at(r_temp.expires_at)
      [old_response, r_temp.expires_at - Time.now]

    when Net::HTTPSuccess
      r = Resterl::Response.new(new_response)
      [r, r.expires_at - Time.now]
    else
      raise 'unknown response'
    end

    # Cachezeit berechnen
    expiry = [
      max_age_seconds.to_i * options[:expiry_multiplier],
      options[:minimum_cache_lifetime]
    ].max

    # Ergebnis im Cache speichern
    @cache.write cache_key, response, expiry

    response
  end

  def setup_url url
    if url =~ /^http/
      url
    else
      bu = options[:base_uri]
      bu ? "#{bu}#{url}" : url
    end
  end

  def data_to_cache_key *args
    args.hash
  end
end
