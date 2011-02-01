namespace :db do
  require 'rubygems'
  require 'dm-core'
  require 'dm-migrations'
  require 'dm-sqlite-adapter'
  require 'swish'

  require 'models'
  # DataMapper configuration
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
  DataMapper.auto_upgrade!

  task :migrate do
    DataMapper.auto_migrate!
  end

  task :seed do
    start = ENV['START'].to_i
    finish = ENV['FINISH'].to_i
    if start > 0 and finish > 0
      print "Feeding in Dribbble shots from IDs #{start} to #{finish}"
      (start..finish).each do |i|
        shot = Dribbble::Shot.find(i)
        if not (shot.title.nil? or Shot.get(:dribbble_id => i))
          Shot.create(:dribbble_id => i, :title => shot.title, :author_name => shot.player.name, :image_url => shot.image_url, :creation_url => shot.url, :votes => 0)
        end

        print '.'; $stdout.flush
      end

      puts ' done.'
    end
  end
end
