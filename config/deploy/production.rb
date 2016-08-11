set :stage, :production
set :server_name, '52.40.156.12'

set :ssh_options, {
    user: "ubuntu",

    keys: %w(/Users/hanks/Documents/Development/hankshou.pem),
    forward_agent: true
}


set :deploy_to, "/data/www/hankshou"

set :unicorn_config, "#{shared_path}/config/unicorn.conf.rb"
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

server fetch(:server_name), user: "ubuntu", roles: %w{web app db}