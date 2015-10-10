# config valid only for Capistrano 3.1
lock '3.4.0'

set :stages, %w(testing production)
set :default_stage, "production"


set :application, 'hankshou'
set :repo_url, 'git@bitbucket.org:hankshou/hankshou.git'

set :rails_env, 'production'

set :rvm_type, :user
set :rvm_ruby_version, '2.2.0'

set :branch, "master" # proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp public/system public/assets public/uploads public/soundink_codes}

set :keep_releases, 5

namespace :deploy do

  task :start do 
    invoke :"rvm:hook"
    on roles :app do
      within current_path do
        unless test("[ -f #{fetch(:unicorn_pid)} ]")
          info ">>>>>> starting unicorn"
          execute :bundle, "exec unicorn_rails -c #{fetch(:unicorn_config)} -D -E #{fetch(:rails_env)}"
        else
          error ">>>>>> unicorn already started"
        end
      end
    end
  end

  task :stop do 
    on roles :app do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        info ">>>>>> stopping unicorn"
        execute "kill `cat #{fetch(:unicorn_pid)}`"
      else
        error ">>>>>> can not stop. there is no started unicorn"
      end
    end
  end

  task :graceful_stop do
    on roles :app do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        info ">>>>>> graceful stop unicorn"
        execute "kill -s QUIT cat `#{fetch(:unicorn_pid)}`"
      else
        error ">>>>>> can not stop. there is no started unicorn"
      end
    end
  end

  task :restart do
    pid = nil
    on roles :app do
      if pid = test("[ -f #{fetch(:unicorn_pid)} ]")
        info ">>>>>> soft restarting unicorn"
        execute "kill -s USR2 `cat #{fetch(:unicorn_pid)}`"
      else
        error ">>>>>> can not restart. there is no started unicorn. will run deploy:start"
      end
    end
    
    invoke "deploy:start" unless pid
  end

  task :force_restart do
    invoke :"deploy:stop"
    invoke :"deploy:start"
  end

  after :finishing, 'deploy:cleanup'

end

before "deploy:cleanup_assets", "rvm:hook"
before "deploy:compile_assets", "rvm:hook"
before "bundler:install", "rvm:hook"
after "deploy:publishing", "deploy:restart"
# after "deploy:publishing", "kindeditor:restart"

namespace :kindeditor do
  task :assets do
    on roles :app do
      within current_path do
        execute :rake, "kindeditor:assets"
      end
    end
  end
end
