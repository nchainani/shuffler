# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shuffler/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Naren Chainani"]
  gem.email         = ["naren.chainani@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shuffler"
  gem.require_paths = ["lib"]
  gem.version       = Shuffler::VERSION


  gem.add_development_dependency('rspec')
end
