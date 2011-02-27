namespace :db do
  require 'rubygems'
  require 'dm-core'
  require 'dm-migrations'
  require 'dm-sqlite-adapter'
  require 'swish'

  require './models.rb'
  # DataMapper configuration
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/development.sqlite3")
  DataMapper.auto_upgrade!

  task :migrate do
    DataMapper.auto_migrate!
  end

  task :seed do
    num_pages = ENV['PAGES'].to_i
    if num_pages > 0
      print "Feeding in the (#{num_pages} * 30) most popular Dribbble shots"
      (1..num_pages).each do |page|
        shots = Dribbble::Shot.popular(:page => page, :per_page => 30)
        shots.each do |shot|
          d_id = shot.url[26..(shot.url =~ %r[-]) - 1].to_i
          if Shot.all(:dribbble_id => d_id).empty?
            Shot.create(:dribbble_id => d_id,
                        :title => shot.title,
                        :author_name => shot.player.name,
                        :image_url => shot.image_url,
                        :creation_url => shot.url,
                        :votes => 0)
            print '.'; $stdout.flush
          end
        end
      end
      puts ' done.'
    end
  end
end
