# Tell Bundler to require all our gems
require 'bundler/setup'
Bundler.require :default, :"#{ENV['RACK_ENV']}"

# Models
require './models.rb'

# Rack configuration
configure do
  if ENV['RACK_ENV'].eql? 'development'
    DataMapper::Logger.new STDOUT, :debug
  end
  DataMapper.setup :default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3"
end
