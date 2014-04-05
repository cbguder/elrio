require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "elrio"

RSpec.configure do |config|
  config.order = "random"
end
