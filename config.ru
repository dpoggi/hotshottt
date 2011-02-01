# Shotgun command-line switches
#\ -s thin -o 0.0.0.0

require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'swish'
require 'haml'
require 'rack/google-analytics'

# Models
require './models.rb'

# Configuration
configure do
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
  DataMapper.auto_upgrade!

  use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
end

require './hotshottt.rb'
run Hotshottt
