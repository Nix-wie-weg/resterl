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

# TODOs Prio 2:
# * Nach Möglichkeit unsere Bibliothek auf Basis von Faraday
# * Caching mit Tests absichern
# * Objekte auch in den Cache? Ja, im Idealfall nur die Objekte
# * Komplettes User-Framework
# * Memoization
# * Eigener Client?
# * Cookie mit remember-Token?
# * Persistente Verbindungen

# TODOs ID-Service-Integration
# * Anforderungen in Kunden-DB-2 prüfen
#   * Zentrale Frage: Fallback-Lösung notwendig?
#   * Eher zweiten ID-Server?


# Composition-Pattern?


=begin
Beispiel Kunden-DB:

User-Model
* Holt prename, email, wiki_name
* Hat in der Tabelle login
* Merkt sich den User über ein remember_token in einem Cookie

Zusätzlich lib/authenticated_system.rb

=end




=begin
http://www.slideshare.net/pengwynn/json-and-the-apinauts

Transports

Net::HTTP
Patron      http://toland.github.com/patron/
Typhoeus    http://github.com/pauldix/typhoeus
em-http-request   http://github.com/igrigorik/em-http-request

Parsers

Crack       http://github.com/jnunemaker/crack
yajl-ruby   http://github.com/brainmario/yajl-ruby
multi_json  http://github.com/intridea/multi_json


Higher Level Libs

HTTParty      http://github.com/jnunemaker/httparty
monster_mash  http://github.com/dbalatero/monster_mash
RestClient    http://github.com/adamwiggins/rest-client
Weary         http://github.com/mwunsch/weary
RackClient    http://github.com/halorgium/rack-client
Faraday       http://github.com/technoweenie/faraday
Faraday Middleware  http://github.com/pengwynn/faraday-middleware


Tools

Hashie
hurl
HTTPScoop
Charles Proxy



url = 'http://api.twitter.com/1'
conn = Faraday::Connection.new(:url => url ) do |builder|
  builder.adapter Faraday.default_adapter
  builder.use Faraday::Response::MultiJson
  builder.use Faraday::Response::Mashify
end

resp = conn.get do |req|
  req.url '/users/show.json', :screen_name => 'pengwynn'
end

u = resp.body
u.name
# => "Wynn Netherland"


=end
