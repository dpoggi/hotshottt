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
    print 'Creating some sample shots'
    (100000..101000).each do |i|
      shot = Dribbble::Shot.find(i)
      if !shot.title.nil? and !Shot.get(:dribbble_id => i)
        Shot.create(:dribbble_id => i, :title => shot.title, :author_name => shot.player.name, :image_url => shot.image_url, :creation_url => shot.url, :votes => 0)
      end

      print '.'; $stdout.flush
    end

    puts ' done.'
  end
end
