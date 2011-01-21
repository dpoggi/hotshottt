# Models
require 'models'

# Controller/Routes
class Hotshottt < Sinatra::Base
  
  get '/' do
    #haml :index
  end
  
  get '/leaderboard' do
    @shots = Shot.all(:order => 'votes').last(10).reverse
    haml :leaderboard
  end

end
