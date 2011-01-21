require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'active_record'
require 'swish'
require 'haml'

require 'hotshottt'
run Hotshottt
