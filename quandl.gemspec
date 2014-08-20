# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quandl/version'

Gem::Specification.new do |spec|
  spec.name          = 'quandl_ruby'
  spec.version       = Quandl::VERSION
  spec.authors       = ['Kash Nouroozi']
  spec.email         = ['hi@knrz.co']
  spec.summary       = %q{Ruby wrapper for the Quandl API (www.quandl.com)}
  spec.description   = ''
  spec.homepage      = 'https://github.com/knrz/Quandl-Ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
end
