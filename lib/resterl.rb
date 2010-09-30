require 'net/http'
require 'net/https'
require 'yajl/json_gem'
################################################################################
module Resterl; end
module Resterl::Caches; end
################################################################################
require 'resterl/class_level_inheritable_attributes'

# Caches
require 'resterl/caches/cache_interface'
require 'resterl/caches/redis_cache'
require 'resterl/caches/simple_cache'
require 'resterl/caches/rails_memcached_cache'
require 'resterl/caches/key_prefix_decorator'

require 'resterl/client'
require 'resterl/request'
require 'resterl/response'
require 'resterl/base_object'

################################################################################
Net::HTTP.version_1_1
################################################################################
