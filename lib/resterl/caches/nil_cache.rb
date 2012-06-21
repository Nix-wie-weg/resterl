# Disable caching with the NilCache :-)
class Resterl::Caches::NilCache < Resterl::Caches::CacheInterface
  def read key
    nil
  end
  def write key, value, expires_in
    value
  end
  def delete key
    nil
  end
end