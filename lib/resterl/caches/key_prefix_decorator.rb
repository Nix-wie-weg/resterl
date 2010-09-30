class Resterl::Caches::KeyPrefixDecorator < Resterl::Caches::CacheInterface
  def initialize cache, key_prefix
    @cache = cache
    @key_prefix = key_prefix
  end
  def read key
    @cache.read key_ext(key)
  end
  def write key, value, expires_in
    @cache.write key_ext(key), value, expires_in
  end
  def delete key
    @cache.delete key_ext(key)
  end

  private

  def key_ext key
    "#{@key_prefix}#{key}"
  end
end
