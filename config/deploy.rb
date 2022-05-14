# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :user,            'deploy'
set :stages, %w(production staging)
set :default_stage, 'staging'

set :application, "richims"
set :repo_url, "git@github.com/ricardo5401/richims_portal.git"

set :deploy_via,              :remote_cache
set :deploy_to,               "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,               "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,              "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,                "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log,         "#{release_path}/log/puma.access.log"
set :puma_error_log,          "#{release_path}/log/puma.error.log"
set :puma_phased_restart,     true # Zero downtime deployment
set :ssh_options,             { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app,        true
set :puma_worker_timeout,     nil
set :puma_init_active_record, true

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads"

namespace :puma do
end

namespace :deploy do

	desc 'Initial Deploy'
	task :initial do
		on roles(:app) do
			before :deploy, 'deploy:create_shared_folders'
			before 'deploy:restart', 'puma:start'
			invoke 'deploy'
		end
	end

	desc 'Create shared folders'
	task :create_shared_folders do
		on roles(:all) do
			execute "mkdir #{shared_path}/sockets -p"
			execute "mkdir #{shared_path}/tmp -p"
			execute "mkdir #{shared_path}/tmp/pids -p"
			execute "mkdir #{shared_path}/log -p"
			execute "mkdir #{shared_path}/tmp/sockets -p"
			execute "touch #{shared_path}/sockets/puma.sock"
			execute "touch #{shared_path}/sockets/pumactl.sock"
			execute "touch #{shared_path}/tmp/pids/puma.state"
			execute "touch #{shared_path}/log/sidekiq.log"
			execute "touch #{shared_path}/log/puma_access.log"
			execute "touch #{shared_path}/log/puma_error.log"
		end
	end

	desc 'Restart application'
	task :restart do
		on roles(:app), in: :sequence, wait: 5 do
			invoke 'puma:restart'
		end
	end

	desc 'Append enviroment vars'
	task :link_env do
		on roles(:web) do
			execute("ln -s ~/.env #{release_path}/.env")
		end
	end

	after  :finishing,    :cleanup
	before 'deploy:migrate', :link_env
	after  :finishing, :restart
end