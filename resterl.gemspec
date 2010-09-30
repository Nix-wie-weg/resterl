# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{resterl}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Dütsch"]
  s.date = %q{2010-09-30}
  s.email = %q{florian.duetsch@nix-wie-weg.de}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO.rdoc",
     "VERSION",
     "lib/resterl.rb",
     "lib/resterl/base_object.rb",
     "lib/resterl/caches/cache_interface.rb",
     "lib/resterl/caches/key_prefix_decorator.rb",
     "lib/resterl/caches/rails_memcached_cache.rb",
     "lib/resterl/caches/redis_cache.rb",
     "lib/resterl/caches/simple_cache.rb",
     "lib/resterl/class_level_inheritable_attributes.rb",
     "lib/resterl/client.rb",
     "lib/resterl/request.rb",
     "lib/resterl/response.rb",
     "resterl.gemspec",
     "test/helper.rb",
     "test/test_resterl.rb"
  ]
  s.homepage = %q{http://github.com/Nix-wie-weg/resterl}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rudimentary HTTP client with focus on caching}
  s.test_files = [
    "test/helper.rb",
     "test/test_resterl.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<hashie>, ["~> 0.4.0"])
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 0.7.7"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<hashie>, ["~> 0.4.0"])
      s.add_dependency(%q<yajl-ruby>, ["~> 0.7.7"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<hashie>, ["~> 0.4.0"])
    s.add_dependency(%q<yajl-ruby>, ["~> 0.7.7"])
  end
end

