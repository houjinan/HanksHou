application     = "kiwi"
remote_user     = "soar"

dir = "source"

env = ENV["RAILS_ENV"] || "development"
RAILS_ROOT = File.join("/home", remote_user, dir,application)
 
worker_processes 8
timeout 30
preload_app true
 
working_directory RAILS_ROOT

listen File.join(RAILS_ROOT, "tmp/unicorn.sock"), :backlog => 64
listen 3000

pid_path = File.join(RAILS_ROOT, "tmp/pids/unicorn.pid")
pid pid_path
 
stderr_path File.join(RAILS_ROOT, "log/unicorn-err.log")
stdout_path File.join(RAILS_ROOT, "log/unicorn-err.log")
 
before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  old_pid_path = "#{pid_path}.oldbin"
  if File.exists?(old_pid_path) && server.pid != old_pid_path
    begin
      Process.kill("QUIT", File.read(old_pid_path).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
 
  # worker processes http://devmull.net/articles/unicorn-resque-bluepill
  # rails_env = ENV['RAILS_ENV'] || 'production'
  # worker.user('app', 'app') if Process.euid == 0 && rails_env == 'production'
end