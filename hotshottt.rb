# Controller/Routes
class Hotshottt < Sinatra::Base
  
  # Configure Sinatra
  configure do
    disable :run
    enable :static
    set :public, File.join(File.dirname(__FILE__), 'public')
    set :views, File.join(File.dirname(__FILE__), 'views')

    # Configure Haml
    set :haml, {:format => :html5}
  end
  
  get '/' do
    num1 = rand(Shot.count - 2) + 1
    num2 = rand(Shot.count - 2) + 1
    while num2 == num1
      num2 = rand(Shot.count - 2) + 1
    end
    
    @shot1 = Shot.get(num1)
    @shot2 = Shot.get(num2)
    if @shot1.upvotes + @shot1.downvotes == 0
      @shot1_percent = 0.0
    else
      @shot1_percent = 100.0 * (@shot1.upvotes.to_f / (@shot1.upvotes.to_f + @shot1.downvotes.to_f))
    end
    @shot1_percent = @shot1_percent.round(2)
    
    if @shot2.upvotes + @shot2.downvotes == 0
      @shot2_percent = 0.0
    else
      @shot2_percent = 100.0 * (@shot2.upvotes.to_f / (@shot2.upvotes.to_f + @shot2.downvotes.to_f))
    end
    @shot2_percent = @shot2_percent.round(2)
    
    haml :index
  end
  
  get '/leaderboard' do
    @shots = Shot.all(:order => [ :upvotes.desc ], :limit => 10)
    haml :leaderboard
  end
  
  get '/vote/:up/:down' do
    @upshot = Shot.get(params[:up])
    @downshot = Shot.get(params[:down])
    
    if @upshot and @downshot and @upshot.valid? and @downshot.valid?
      repeat_voters = IP.all(:ip_address => request.ip,
                             :vote_combo_list.like => "% #{params[:up]}/#{params[:down]} %")
      if repeat_voters.empty?
        repeat_voter = IP.first(:ip_address => request.ip)
        if repeat_voter and repeat_voter.valid?
          repeat_voter.vote_combo_list += " #{params[:up]}/#{params[:down]} "
          repeat_voter.save
        else
          IP.create(:ip_address => request.ip,
                    :vote_combo_list => " #{params[:up]}/#{params[:down]} ")
        end

        @upshot.upvotes += 1
        @upshot.save
        @downshot.downvotes += 1
        @downshot.save
      end
      redirect '/'
    else
      if @upshot
        @upshot.errors.each {|error| puts error}
      end
      if @downshot
        @downshot.errors.each {|error| puts error}
      end
      "Error voting for shot: #{params[:up]}."
    end
  end

  not_found do
    redirect '/'
  end

end
