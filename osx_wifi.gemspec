# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osx_wifi/version'

Gem::Specification.new do |spec|
  spec.name          = 'osx_wifi'
  spec.version       = OsxWifi::VERSION
  spec.authors       = ['Tyler Duzan']
  spec.email         = ['tristor@tristor.ro']

  spec.summary       = 'OSX WiFi Signal Strength Indicator'
  spec.description   = 'This is a simple gem to return a relative indicator of WiFi signal strength on OSX similar to the 4 bars.  Useful for integration into a shell prompt.'
  spec.homepage      = 'https://github.com/tristor/osx_wifi/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'mixlib-shellout', '~> 2.2.7'
end
