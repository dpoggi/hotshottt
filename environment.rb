require 'bundler/setup'
Bundler.require(:default, (ENV['RACK_ENV'] || 'development').to_sym)

# Models
require './models.rb'

# Rack configuration
configure do
  if ENV['RACK_ENV'] == 'development'
    DataMapper::Logger.new(STDOUT, :debug)
  end

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")

  if ENV['RACK_ENV'] == 'production'
    use Rack::GoogleAnalytics, :tracker => 'UA-21127535-1'
  end
end
