# Rackup file

# Shotgun command-line switches
#\ -s thin -o 0.0.0.0

require 'bundler'
Bundler.require(:default, ENV['DATABASE_URL'] ? :production : :development)

# Models
require './models.rb'

# Rack configuration
configure do
  if not ENV['DATABASE_URL']
    DataMapper::Logger.new(STDOUT, :debug)
  end

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
  DataMapper.auto_upgrade!

  use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
end

require './hotshottt.rb'
run Hotshottt
