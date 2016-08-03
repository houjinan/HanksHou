namespace :mongodb do
  task :shell do
    project_env = ENV["RAILS_ENV"].present? ? ENV["RAILS_ENV"] : "development"
    Mongoid.load! File.join(Rails.root, "config/mongoid.yml"), project_env
    system Mongoid::Shell::Commands::Mongo.new.to_s
  end
end