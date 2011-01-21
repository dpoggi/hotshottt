require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'active_record'
require 'swish'
require 'haml'

# ActiveRecord setup
db_config = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection db_config[settings.environment.to_s]

# Haml configuration
set :haml, {:format => :html5}

require 'hotshottt'
run Hotshottt