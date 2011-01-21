require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'swish'
require 'haml'

# DataMapper configuration
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://development.sqlite3')

# Haml configuration
set :haml, {:format => :html5}

require 'hotshottt'
run Hotshottt
