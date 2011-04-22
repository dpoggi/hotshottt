# Load environment
require File.join(File.dirname(__FILE__), 'config', 'environment.rb')

# Rack configuration for Google Analytics
configure do
  use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1' if ENV['RACK_ENV'].eql? 'production'
end

require File.join(File.dirname(__FILE__), 'hotshottt.rb')
run Hotshottt
