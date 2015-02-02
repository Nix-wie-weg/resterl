# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "resterl/version"


Gem::Specification.new do |s|
  s.name = 'resterl'
  s.version = Resterl::VERSION
  s.authors = ["Florian Dütsch"]
  s.email = 'florian.duetsch@nix-wie-weg.de'
  s.homepage = 'http://github.com/Nix-wie-weg/resterl'
  s.summary = 'Rudimentary HTTP client with focus on caching'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f|File.basename(f)}
  #s.require_paths = ["lib"]

  s.add_runtime_dependency 'activesupport', '>= 2.3.18'
  s.add_runtime_dependency 'hashie', '~> 0.4.0'
  s.add_runtime_dependency 'yajl-ruby', '~> 1.1'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'webmock', '~> 1.20.4'
  s.add_development_dependency 'timecop', '~> 0.7.1'
  s.add_development_dependency 'pry'
end
