# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in array-subindex.gemspec
gemspec

# can't use pry on old rubies or on rubinius
if RUBY_VERSION.to_f >= 2.0 && RUBY_ENGINE == 'ruby'
  gem 'codeclimate-test-reporter'
  gem 'pry', require: false
  gem 'pry-byebug', require: false
end
