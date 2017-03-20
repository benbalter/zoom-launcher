# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoom_launcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'zoom_launcher'
  spec.version       = ZoomLauncher::VERSION
  spec.authors       = ['Ben Balter']
  spec.email         = ['ben.balter@github.com']

  spec.summary       = ''
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionview'
  spec.add_dependency 'colored'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'google-api-client'
  spec.add_dependency 'os'
  spec.add_dependency 'thor'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
