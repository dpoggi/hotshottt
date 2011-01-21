# Models
require 'models'

# Controller/Routes
class Hotshottt < Sinatra::Base
  
  get '/' do
    haml :index
  end
  
  get '/leaderboard' do
    haml :leaderboard
  end

end
