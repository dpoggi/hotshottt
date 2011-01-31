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
    
    if @shot and @shot.valid?
      offending_IPs = IP.all(:ip_address => request.ip, :shot_id_list.like => "% #{params[:id]} %")
      if offending_IPs.empty?
        existing_IP = IP.first(:ip_address => request.ip)
        if existing_IP and existing_IP.valid?
          existing_IP.shot_id_list += " #{params[:id]} "
          existing_IP.save
        else
          IP.create(:ip_address => request.ip, :shot_id_list => " #{params[:id]} ")
        end

        @shot.votes += 1
        @shot.save
      end
      redirect '/'
    else
      if @shot
        @shot.errors.each {|error| puts error}
      end
      "Error voting for shot: #{params[:id]}."
    end
  end

  not_found do
    redirect '/'
  end

end
