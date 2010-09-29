require 'net/http'
require 'net/https'
require 'yajl/json_gem'
################################################################################
module Resterl; end
################################################################################
#require 'resterl/class_level_inheritable_attributes'
require 'resterl/cache_interface'
require 'resterl/redis_cache'
require 'resterl/simple_cache'
require 'resterl/client'
require 'resterl/request'
require 'resterl/response'
require 'resterl/base_object'
################################################################################
Net::HTTP.version_1_1
################################################################################
