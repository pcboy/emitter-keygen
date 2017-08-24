# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emitter/keygen/version'

Gem::Specification.new do |spec|
  spec.name          = "emitter-keygen"
  spec.version       = Emitter::Keygen::VERSION
  spec.authors       = ["David Hagege"]
  spec.email         = ["david.hagege@gmail.com"]

  spec.summary       = %q{A small gem to do the emitter.io channel key generation in ruby}
  spec.homepage      = "https://github.com/pcboy/emitter-keygen"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency 'paho-mqtt', '~> 1.0'
end
