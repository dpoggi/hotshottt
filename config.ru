# Rackup file

# Shotgun command-line switches
#\ -s thin -o 0.0.0.0

require './environment.rb'

# Hack to make Google Analytics work :(
configure do
  use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
end

require './hotshottt.rb'
run Hotshottt
