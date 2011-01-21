namespace :db do
  task :migrate do
    migrations_file = "./db/migrations.rb"
    puts "Migrating DB from: #{migrations_file}"
    load(migrations_file) if File.exist?(migrations_file)
  end

  task :seed do
    seed_file = "./db/seeds.rb"
    puts "Seeding DB from: #{seed_file}"
    load(seed_file) if File.exist?(seed_file)
  end
end
