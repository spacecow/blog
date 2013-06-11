#require 'bundler/capistrano'
#
##default_run_options[:shell] = '/bin/bash --login' 
#set :default_environment, {
#  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
#}
#
#server "viper.fir-vpc.riec.tohoku.ac.jp", :web, :app, :db, primary:true
#
#set :application, "blog"
#set :user, "habu"
#set :deploy_to, "/home/#{user}/apps/#{application}"
#set :deploy_via, :remote_cache
#set :use_sudo, false
#
##set :admin_runner, "habu"
#  
#set :scm, "git"
#set :repository, "git@github.com:spacecow/blog.git"
#set :branch, "master"
#
#default_run_options[:pty] = true
#ssh_options[:forward_agent] = true
#
#after "deploy", "deploy:cleanup" # keep only the last 5 releases
#
##after 'deploy:update_code', 'deploy:symlink_shared'
##after 'deploy:finalize_update', 'deploy:symlink_shared'
#
#namespace :deploy do
#  %w[start stop reload upgrade].each do |command|
#    desc "#{command} unicorn server"
#    task command, roles: :app, except: {no_release: true} do
#      run "/etc/init.d/unicorn_#{application} #{command}"
#    end
#  end
#
#  task :setup_config, roles: :app do
#    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#    #sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
#    run "mkdir -p #{shared_path}/config"
#    #put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
#    puts "Now edit the config files in #{shared_path}."
#  end
#  after "deploy:setup", "deploy:setup_config"
#
#  #task :start do ; end
#  #task :stop do ; end
#  #task :restart, :roles => :app, :except => { :no_release => true } do
#  #  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  #end
#
#  desc "Symlinks the database.yml"
#  task :symlink_config, roles: :app do
#    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#  end
#  after "deploy:finalize_update", "deploy:symlink_config"
#
#  desc "Make sure local git is in sync with remote."
#  task :check_revision, roles: :web do
#    unless `git rev-parse HEAD` == `git rev-parse origin/master`
#      puts "WARNING: HEAD is not the same as origin/master"
#      puts "Run `git push` to sync changes."
#      exit
#    end
#  end
#  before "deploy", "deploy:check_revision"
#
#  #task :symlink_shared, roles: :app do
#  #  run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
#  #end
#end
#


require "bundler/capistrano"

server "viper.fir-vpc.riec.tohoku.ac.jp", :web, :app, :db, primary: true

set :application, "blog"
set :user, "habu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:spacecow/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"


  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"    
  end
  after "deploy:finalize_update", "deploy:symlink_config"


  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
