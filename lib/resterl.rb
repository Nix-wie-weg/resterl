require 'net/http'
require 'net/https'
require 'yajl/json_gem'
################################################################################
module Resterl
  module Caches; end
end
################################################################################
require 'resterl/class_level_inheritable_attributes'

# Caches
require 'resterl/caches/cache_interface'
require 'resterl/caches/redis_cache'
require 'resterl/caches/simple_cache'
require 'resterl/caches/rails_memcached_cache'
require 'resterl/caches/key_prefix_decorator'
require 'resterl/caches/cache_key_generator'
require 'resterl/caches/nil_cache'

require 'resterl/client'
require 'resterl/generic_request'
require 'resterl/get_request'
require 'resterl/post_request'
require 'resterl/put_request'
require 'resterl/delete_request'
require 'resterl/response'
require 'resterl/base_object'
