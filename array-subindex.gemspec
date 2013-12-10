# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'array/subindex/version'

Gem::Specification.new do |spec|
  spec.name          = "array-subindex"
  spec.version       = Array::Subindex::VERSION
  spec.authors       = ["Matthew Nielsen"]
  spec.email         = ["xunker@pyxidis.org"]
  spec.description   = %q{Access sub-integer array indexes in Ruby: Array.new([1,2])[0.5] == 1.5}
  spec.summary       = %q{Access sub-integer array indexes in Ruby: Array.new([1,2])[0.5] == 1.5}
  spec.homepage      = "https://github.com/xunker/array-subindex"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  # spec.add_development_dependency "debugger"
end
