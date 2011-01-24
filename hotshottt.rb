# Controller/Routes
class Hotshottt < Sinatra::Base
  
  # Sinatra configuration
  enable :static
  set :public, 'public'
  
  # Haml configuration
  set :haml, {:format => :html5}
  
  get '/' do
    num1 = rand(Shot.count - 2) + 1
    num2 = rand(Shot.count - 2) + 1
    while num2 == num1
      num2 = rand(Shot.count - 2) + 1
    end
    
    @shot1 = Shot.get(num1)
    @shot2 = Shot.get(num2)
    haml :index
  end
  
  get '/leaderboard' do
    @shots = Shot.all(:order => [ :votes.desc ], :limit => 10)
    haml :leaderboard
  end
  
  get '/vote/:id' do
    @shot = Shot.get(params[:id])
    
    @shot.votes += 1
    if @shot.save!
      redirect '/'
    else
      "Error voting for #{@shot.title}."
    end
  end

end
