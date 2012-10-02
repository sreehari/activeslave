# -*- encoding: utf-8 -*-
require File.expand_path('../lib/activeslave/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sreehari B"]
  gem.email         = ["sreehari@activesphere.com"]
  gem.description   = %q{monitor mysql slave}
  gem.summary       = %q{monitor mysql slave}
  gem.homepage      = "https://github.com/sreehari/activeslave"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "mysql2"
  gem.add_development_dependency "pony"
  gem.add_development_dependency "rufus-scheduler"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activeslave"
  gem.require_paths = ["lib"]
  gem.version       = Activeslave::VERSION
end
