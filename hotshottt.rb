# Controller/Routes
class Hotshottt < Sinatra::Base
  
  # Configure Sinatra
  configure do
    disable :run
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

    # Function to get around DataMapper's shittiness when it comes to errors.
    # Validates all the objects given, and either yields to the block or
    # prints the errors. What a bitchmonkey.
    def if_valid_rows(*rows)
      rows_exist = !rows.include?(nil)
      rows_valid = rows.inject do |result, row|
        if result and row
          result = row.valid?
        else
          result = false
        end
      end

      if rows_exist and rows_valid
        yield
        true
      else
        rows.each {|row| row ? row.errors.each {|error| puts error} : nil}
        false
      end
    end

    # Encodes an event for a winner and a loser. Jesus this is a hack. Hack hack hack.
    def encode_event(winner, loser)
      " #{winner.id}/#{loser.id} "
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
 
  # Does the voting.
  get '/vote/:winner/:loser' do
    winner, loser = Shot.get(params[:winner].to_i), Shot.get(params[:loser].to_i)

    if_valid_rows winner, loser do
      repeat_voters = IP.all(:ip_address => request.ip,
                             :vote_combo_list.like => "%#{encode_event(winner, loser)}%")
      if repeat_voters.empty?
        repeat_voter = IP.first(:ip_address => request.ip)
        is_repeat_voter = if_valid_rows repeat_voter do
          repeat_voter.vote_combo_list += encode_event(winner, loser)
          repeat_voter.save
        end
        if not is_repeat_voter
          IP.create(:ip_address => request.ip,
                    :vote_combo_list => encode_event(winner, loser))
        end

        winner.upvotes += 1
        loser.downvotes += 1
        [winner, loser].each {|shot| shot.save}
      end
      redirect '/'
    end
  end

  # Get an SCSS stylesheet
  get '/stylesheets/:sheet.css' do
    scss_options = {:syntax => :scss}
    if ENV['RACK_ENV'].eql? 'production'
      scss_options.merge!({:style => :compressed})
    end

    scss :"#{params[:sheet]}", scss_options
  end
  
  not_found do
    redirect '/'
  end

end
