# Default our Rack environment
ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?

# Tell Bundler to require all our gems
require 'bundler/setup'
Bundler.require :default, :"#{ENV['RACK_ENV']}"

# Models
require File.join(File.dirname(__FILE__), 'schema.rb')

# Rack configuration
configure do
  dm_config = YAML.load(File.new(File.join(File.dirname(__FILE__), 'database.yml')))
  DataMapper.setup :default, dm_config[ENV['RACK_ENV']] 
end
