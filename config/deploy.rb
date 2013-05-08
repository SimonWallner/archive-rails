# Capistrano deploy file
# see documentation section below, on how to prepare the server and what
# to set up where

# deploy with bundler
require 'bundler/capistrano'

set :application, "game_archive"
set :domain, "46.163.119.27"
set :deploy_to, "/var/www/ror-archive"
set :rails_env, "production"
set :user, "capistrano"
set :use_sudo, true


set :scm, :git
set :repository, "git://github.com/SimonWallner/archive-rails.git"
set :deploy_via, :remote_cache # chache the repo instead of a full checkout every time


role :web, domain	# Your HTTP server, Apache/etc
role :app, domain	# This may be the same as your `Web` server
role :db, domain, :primary => true # This is where Rails migrations will run

# manually add rvm and ruby paths
# there probably is a better way to do that
set :default_environment, {
  'PATH' => "/usr/local/rvm/gems/ruby-1.9.3-p385/bin:/usr/local/rvm/gems/ruby-1.9.3-p385@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p385/bin:/usr/local/rvm/bin:$PATH"
}
default_run_options[:pty] = true

# run migrations afeter every deploy
after 'deploy:update_code', 'deploy:migrate'


namespace :deploy do
	desc "Symlink shared files like database.yml into the release folder"
	task :symlink_shared_files do
		run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
		run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
	end
	
	desc "fix access rights for certain folders and files"
	task :fix_access_rights do
		run "#{try_sudo} chown -R capistrano:psacln #{release_path}/tmp/"
		run "#{try_sudo} chmod -R g+w #{release_path}/tmp/"
	end
	
	desc "start nginx"
	task :start do
		run "/etc/init.d/nginx start"
	end
	
	desc "stop nginx"
	task :stop do
		run "/etc/init.d/nginx stop"
	end
	
	desc "restart passenger"
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	end
end

namespace :logs do
	desc "tail the production log"
	task :production do
		run "tail -f #{current_release}/log/production.log"
	end
end

after 'deploy:update_code', 'deploy:symlink_shared_files'
after 'deploy:update_code', 'deploy:fix_access_rights'
after "deploy:restart", "deploy:cleanup"


## DOCUMENTATION
# This deploy setup relies on a few things on the server side in order to 
# function correctly. Especially all the commands that link to shared
# resources require those resources to be present in the first place
# 
# 
# -- Database config -- 
# put a database.yml file in /shared/config/
# for mysql it looks something like this:
# 
# production:
#   adapter: mysql2
#   encoding: utf8
#   database: <db name>
#   username: <db user>
#   password: <pwd>
#   host: localhost
#   port: 3306
#
# The database must also be set up via rake db:setup
# 
# 
# -- production.log -- 
# It looks like capistrano takes care of the production.log and links it
# into the current release. If not, try creating a production.log file in
# /shared/log/. Make sure the www user can write to it
# 
# 
# -- Assets and uploads --
# Uploads are stored in /shared/public/uploads otherwise they are overwriten
# on each deploy. Create the folder /shared/public/uploads and set the 
# appropriate rights.