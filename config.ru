# Load environment
require './config/environment.rb'

# Rack configuration for Google Analytics
configure do
  if ENV['RACK_ENV'].eql? 'production'
    use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
  end
end

require './hotshottt.rb'
run Hotshottt
