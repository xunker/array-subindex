require "bundler/gem_tasks"

require "rspec/core/rake_task"
require "rspec/core/version"

task :default => :spec

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec, :default) do |t|
  t.ruby_opts = %w[-w]
end