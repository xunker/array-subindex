# avoid redundant reports to codeclimate for every version ruby
# version run in travis. This also avoids trying to run test reporter
# under 1.8.7 which will fail.
if RUBY_VERSION == "2.2.1"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

RSpec.configure do |config|
  config.order = "random"
end
