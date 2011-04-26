# Load environment
require './config/environment.rb'

# Rack configuration for Google Analytics
configure do
  use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1' if ENV['RACK_ENV'].eql? 'production'
end

require './hotshottt.rb'
run Hotshottt
