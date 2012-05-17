# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pointsfeed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nisarg Shah"]
  gem.email         = ["nisargshah100@gmail.com"]
  gem.description   = %q{Connects to PointsFeed.in api}
  gem.summary       = %q{Connects to PointsFeed.in api}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pointsfeed"
  gem.require_paths = ["lib"]
  gem.version       = Pointsfeed::VERSION
  gem.add_development_dependency "faraday"
  gem.add_development_dependency "json"
  gem.add_development_dependency "hashie"
end
