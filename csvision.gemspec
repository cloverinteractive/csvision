# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require "csvision/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Enrique Vidal"]
  gem.email         = ["enrique@cloverinteractive.com"]
  gem.description   = %q{Gives Hash the ability to be turned into csv files}
  gem.summary       = %q{Adds support to hashes to be turned into csv}
  gem.homepage      = "http://cloverinteractive.github.com/csvision/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "csvision"
  gem.require_paths = ["lib"]
  gem.version       = CSVision::VERSION

  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'turn', '0.8.2'
end
