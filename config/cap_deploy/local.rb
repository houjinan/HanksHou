set :stage, :production
set :server_name, 'localhost'

set :deploy_to, "/Users/hanks/Documents/site/hankshou"

set :unicorn_config, "#{shared_path}/config/unicorn.conf.rb"
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

server fetch(:server_name), user: "hanks", roles: %w{web app db}