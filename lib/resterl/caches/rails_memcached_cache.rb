require 'forwardable'
class Resterl::Caches::RailsMemcachedCache < Resterl::Caches::CacheInterface
  extend Forwardable

  def initialize client
    @client = client
  end

  def_delegators :@client, :delete

  def read key
    obj = @client.read key
    # Rails freezes the object when putting it put the cache.
    # So unfreeze it:
    obj ? obj.dup : obj
  end
  def write key, value, expires_in
    @client.write key, value, :expires_in => expires_in
  end
end
