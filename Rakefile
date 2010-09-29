require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "resterl"
    gem.summary = %Q{Rudimentary HTTP client with focus on caching}
    gem.description = %Q{Rudimentary HTTP client with focus on caching}
    gem.email = "florian.duetsch@nix-wie-weg.de"
    gem.homepage = "http://nix-wie-weg.de/"
    # TODO
    #gem.authors = ["fduetsch"]
    #gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20
    # for additional settings

    # TODO: Können wir auf einen neuere Version gehen?
    gem.add_dependency 'hashie', '~> 0.4.0'
    gem.add_dependency 'yajl-ruby', '~> 0.7.7'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. " \
       "Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: " \
          "sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "resterl #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
