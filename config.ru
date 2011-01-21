require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'swish'
require 'haml'

# DataMapper configuration
DataMapper.setup(:default,
                 ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/development.sqlite3")

# Haml configuration
set :haml, {:format => :html5}

require 'hotshottt'
run Hotshottt
