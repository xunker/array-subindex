if RUBY_VERSION > "1.8.7"
  # codeclimate reporter no working with < 1.9.3
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

RSpec.configure do |config|
  config.order = "random"
end
