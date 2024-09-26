# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'array/subindex/version'

Gem::Specification.new do |spec|
  spec.name          = 'array-subindex'
  spec.version       = Array::Subindex::VERSION
  spec.authors       = ['Matthew Nielsen']
  spec.email         = ['xunker@pyxidis.org']
  spec.description   = %q{Access sub-integer array indexes in Ruby: Array.new([1,2])[0.5] == 1.5}
  spec.summary       = %q{Access sub-integer array indexes in Ruby: Array.new([1,2])[0.5] == 1.5}
  spec.homepage      = 'https://github.com/xunker/array-subindex'
  spec.license       = 'WTFPL'
  spec.required_ruby_version = '>= 3.2.0'

  # spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '<= 3'
  spec.add_development_dependency 'rake', '~> 13.2.1'
  spec.add_development_dependency 'rspec', '~> 3.13.0'
  spec.add_development_dependency 'rubocop'
end
