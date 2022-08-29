# encoding: utf-8
require File.expand_path('../lib/resterl/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'resterl'
  s.version = Resterl::VERSION
  s.authors = ['Florian Dütsch', 'Stefan Hoffmann']
  s.email = ['florian.duetsch@nix-wie-weg.de', 'stefan.hoffmann@nix-wie-weg.de']
  s.homepage = 'https://github.com/Nix-wie-weg/resterl'
  s.summary = 'Rudimentary HTTP client with focus on caching'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'activesupport', '>= 3.2.0'
  s.add_runtime_dependency 'hashie', '~> 3.5.7'
  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'webmock', '~> 3.4.1'
  s.add_development_dependency 'timecop', '~> 0.9.1'
  s.add_development_dependency 'rubocop', '~> 0.39.0'
  s.add_development_dependency 'pry'
end
