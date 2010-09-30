require 'helper'

class TestResterl < Test::Unit::TestCase

  should 'load successfully' do
    dummy = nil
    cache = Resterl::Caches::KeyPrefixDecorator.new(
      Resterl::Caches::RailsMemcachedCache.new(dummy),
      'prefix_'
    )


    ODIN_CLIENT = Resterl::Client.new(
      :base_uri => 'http://www.google.com/',
      :cache => cache
    )
  end

end
