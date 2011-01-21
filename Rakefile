namespace :db do
  require 'rubygems'
  require 'dm-core'
  require 'dm-migrations'
  require 'dm-sqlite-adapter'
  require 'swish'

  # DataMapper configuration
  DataMapper.setup(:default,
                   ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/development.sqlite3")

  require 'models'

  task :seed do
    print 'Creating some sample shots'
    (100000..101000).each do |i|
      shot = Dribbble::Shot.find(i)
      if not (shot.nil? and Shot.all(:dribbble_id => i))
        Shot.create(:dribbble_id => i, :title => shot.title, :author_name => shot.player.name, :image_url => shot.image_url, :creation_url => shot.url, :votes => 0)
      end

      print '.'; $stdout.flush
    end

    puts ' done.'
  end
end
