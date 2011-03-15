namespace :db do
  require './environment.rb'

  task :upgrade do
    DataMapper.auto_upgrade!
  end

  task :migrate do
    DataMapper.auto_migrate!
  end

  task :seed do
    first_page = ENV['FIRSTPAGE'].to_i
    last_page = ENV['LASTPAGE'].to_i
    first_shot = (first_page - 1) * 30 + 1
    last_shot = (last_page) * 30
    if first_page > 0 and last_page > 0
      print "Feeding in popular Dribbble shots from #s #{first_shot} to #{last_shot}"
      (first_page..last_page).each do |page|
        shots = Dribbble::Shot.popular(:page => page, :per_page => 30)
        shots.each do |shot|
          d_id = shot.url[26..(shot.url =~ %r[-]) - 1].to_i
          if Shot.all(:dribbble_id => d_id).empty?
            Shot.create(:dribbble_id => d_id,
                        :title => shot.title,
                        :author_name => shot.player.name,
                        :image_url => shot.image_url,
                        :creation_url => shot.url,
                        :upvotes => 0,
                        :downvotes => 0)
            print '.'; $stdout.flush
          end
        end
      end
      puts ' done.'
    end
  end
end
