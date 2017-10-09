# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'embedded_model/version'

Gem::Specification.new do |spec|
  spec.name          = 'embedded_model'
  spec.version       = EmbeddedModel::VERSION
  spec.authors       = ['Nikolai Vasilenko']
  spec.email         = ['colormailbox@gmail.com']

  spec.summary       = 'Embeds your PORO models into ActiveRecord ones and stores them as JSON'
  spec.homepage      = 'https://github.com/vasilenko/embedded_model'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 5.1'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.0'
end
