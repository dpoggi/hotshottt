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
  
  # Neato helpers
  helpers do
    # Get [num] unique random numbers with min 1 and max (inclusive) [ceiling]
    def unique_randoms(num, ceiling)
      begin
        arr = Array.new(num) { rand(ceiling - 1) + 1 }
      end until arr.count == arr.uniq.count
      arr
    end

    # Calculate the win percentage = wins / (wins + losses)
    def percent_success(upvotes, downvotes)
      upvotes + downvotes == 0 ? 0.0 : (100.0 * (upvotes.to_f / (upvotes.to_f + downvotes.to_f))).round(2)
    end
  end
 
  # Main "versus" page. View needs two shots, and their calculated win percentages
  get '/' do
    @shot1, @shot2 = unique_randoms(2, Shot.count).map {|id| Shot.get(id)}
    @shot1_percent, @shot2_percent = [@shot1, @shot2].map {|shot| percent_success(shot.upvotes, shot.downvotes)}
    haml :index
  end
 
  # Leaderboard. View needs a properly ordered list of the ten winning-est shots
  get '/leaderboard' do
    @shots = Shot.all(:order => [ :upvotes.desc ], :limit => 10)
    haml :leaderboard
  end
 
  # Does the voting. TODO: Make this NOT a dirty hack
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
