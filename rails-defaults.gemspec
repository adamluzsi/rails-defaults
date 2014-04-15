# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),"files.rb"))

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "rails-defaults"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.description   = %q{ this module let you have super easy to configurate way for rails defaults. if you set anything with this, than starting rails with 'rails s'/'rails server' will use your preset behaviors }
  spec.summary       = %q{ Set up Rails default behaviors with this simple DSL }

  spec.homepage      = "https://github.com/adamluzsi/rails-defaults"
  spec.license       = "MIT"

  spec.files         = RailsDefaults::SpecFiles
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "rack"
  spec.required_ruby_version = '>= 2.0.0'

end
