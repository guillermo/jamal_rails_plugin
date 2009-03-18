

namespace :jamal do
  
  desc "Install Jamal and JQuery.
  Copy all assets to public/javascript and public/stylesheets.
  Create a RAILS_ROOT/client folder to start coding your client app."
  task :install => :environment do
    require 'fileutils'
    JamalMVC::Rake.install and ::Rake::Task['jamal:update_assets'].invoke     
  end
  
  
  
  desc "Update assets app.
  Compile all code under RAILS_ROOT/client to public/javascripts/client.app.js"
  task :update_assets => :environment do
    JamalMVC::Rake.update_assets
  end
  
end

  