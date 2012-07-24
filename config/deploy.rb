set :repository,  'git@github.com:giedriusr/chef-solo.git'
set :scm, :git
set :user, 'root'
set :deploy_via, :remote_cache

desc 'Deploy to production (production environment)'
task :production do
  set :application, 'chef'
  set :environment, 'production'
  set :deploy_to, "/var/#{application}"
  server 'IP', :app, :web, :db, :primary => true
end

namespace :deploy do

  desc 'Uploads chef files to the server'
  task :upload, :except => { :no_release => true } do
    run "scp * root@IP:/var/chef/"
    run "chef-solo -c solo.rb -j roles/application_lamp_server.json"
  end
end