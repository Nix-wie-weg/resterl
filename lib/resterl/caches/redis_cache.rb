class Resterl::Caches::RedisCache < Resterl::Caches::CacheInterface

  def initialize client
    @client = client
  end

  def read key
    dump = @client.get key
    Marshal.load(dump) if dump
  end
  def write key, value, expires_in
    @client.pipelined do
      #@client.multi do
        @client.set key, Marshal.dump(value)
        @client.expire key, expires_in
      #end
    end
  end
  def delete key
    @client.del key
  end
end
