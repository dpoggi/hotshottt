# Default our Rack environment
ENV['RACK_ENV'] ||= 'development'

# Tell Bundler to require all our gems
require 'bundler/setup'
Bundler.require(:default, :"#{ENV['RACK_ENV']}")

# Models
require File.expand_path('../../db/schema.rb', __FILE__)

# Rack configuration
configure do
  dm_config = YAML.load_file(File.expand_path('../database.yml', __FILE__))
  DataMapper.setup(:default, dm_config[ENV['RACK_ENV']])
end
