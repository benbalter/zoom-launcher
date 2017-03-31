# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoom_launcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'zoom_launcher'
  spec.version       = ZoomLauncher::VERSION
  spec.authors       = ['Ben Balter']
  spec.email         = ['ben.balter@github.com']

  spec.summary       = 'A command line tool for joining your next Zoom meeting'
  spec.homepage      = "https://github.com/benbalter/zoom-launcher"
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionview', '~> 5.0'
  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'dotenv', '~> 2.2'
  spec.add_dependency 'google-api-client', '~> 0.10'
  spec.add_dependency 'os', '~> 0.9'
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.48'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'timecop', '~> 0.8'
end
