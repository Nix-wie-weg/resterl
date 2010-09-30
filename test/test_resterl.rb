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

  context 'BaseObject' do
    should 'provide class level inheritable attributes' do

      assert_nil Resterl::BaseObject.resterl_client
      assert_nil Resterl::BaseObject.complete_mime_type

      assert_nothing_raised do
        class Test < Resterl::BaseObject
          self.resterl_client = nil
          self.complete_mime_type = 'text/plain'
        end
      end

    end
    
  end

end
