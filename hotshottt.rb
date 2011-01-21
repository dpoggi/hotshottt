require 'models'

class Hotshottt < Sinatra::Base
  dbconfig = YAML.load(File.read('config/database.yml'))
  ActiveRecord::Base.establish_connection dbconfig['production']

  set :haml, {:format => :html5}

  get '/' do
    "Hotshottt!"
  end
end
