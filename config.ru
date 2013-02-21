# Load environment
require File.expand_path('../config/environment.rb', __FILE__)

# Rack configuration for Google Analytics
configure do
  if ENV['RACK_ENV'] == 'production'
    use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
  end
end

require File.expand_path('../hotshottt.rb', __FILE__)
run Hotshottt
