source 'http://rubygems.org'

gem 'sinatra'
gem 'dm-core'
gem 'dm-migrations'
gem 'dm-validations'
gem 'httparty'
gem 'swish'
gem 'haml'
gem 'sass'

group :development do
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'unicorn'
  gem 'dm-mysql-adapter'
  gem 'rack-google-analytics', :require => 'rack/google-analytics'
end
