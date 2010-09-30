require 'forwardable'
class Resterl::Caches::RailsMemcachedCache < Resterl::Caches::CacheInterface
  extend Forwardable

  def initialize client
    @client = client
  end

  def_delegators :@client, :read, :delete

  def write key, value, expires_in
    @client.write key, value, :expires_in => expires_in
  end
end
