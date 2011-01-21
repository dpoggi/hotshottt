require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'swish'
require 'haml'

# Haml configuration
set :haml, {:format => :html5}

require 'hotshottt'
run Hotshottt
