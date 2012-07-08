# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chef-cooker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kohei Hasegawa"]
  gem.email         = ["ameutau@gmail.com"]
  gem.description   = %q{chef-cooker will be able to create cookbook of Chef easily. yay ;) }
  gem.summary       = %q{chef-cooker will be able to create cookbook of Chef easily. yay ;) }
  gem.homepage      = "http://github.com/banyan/chef-cooker"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chef-cooker"
  gem.require_paths = ["lib"]
  gem.version       = Chef::Cooker::VERSION

  gem.add_runtime_dependency 'thor'
end
