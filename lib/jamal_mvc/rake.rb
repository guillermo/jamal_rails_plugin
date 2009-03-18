module JamalMVC

  module Rake
    class AlreadyInstalled < Exception ; end

    # Install Jamal in the current rails app.
    # If it is already installed, it ask for remove and 
    def self.install
      dest = File.join(RAILS_ROOT,'client')
      raise AlreadyInstalled if File.directory?(dest)
      from = File.join(File.dirname(__FILE__),'../../','template')
      FileUtils.cp_r(from,dest)
      true
    rescue AlreadyInstalled
      puts "Already installed jamal"
      puts "Remove client directory and try again? (ALL DATA IN RAILS_ROOT/client WILL BE ERASE) [Yn]"
      if $stdin.readline.strip =~ /^y$|^yes$|^ok$|^yeah\!?$/i
        FileUtils.rm_rf(dest)
        retry
      end
      false
    end
    
    def self.update_assets
      # Generate jamal
      jamal_files = [JAMAL_ROOT+'/intro.js']
      jamal_files << JAMAL_ROOT+'/jamal.js'
      jamal_files << Dir.glob(JAMAL_ROOT+'/libs/*.js')
      jamal_files << Dir.glob(JAMAL_ROOT+'/components/*.js')
      jamal_files << JAMAL_ROOT+'/startup.js'
      jamal_files << Dir.glob(JAMAL_ROOT+'/plugins/*.js')
      jamal_files << JAMAL_ROOT+'/outro.js'
      
      concat_files(JS_ASSETS+'/jamal.js',jamal_files.flatten)
      
      app_files = [Dir.glob(CLIENT_APP+'/*.js')]
      app_files << Dir.glob(CLIENT_APP+'/models/*.js')
      app_files << Dir.glob(CLIENT_APP+'/views/*.js')
      app_files << Dir.glob(CLIENT_APP+'/controllers/*.js')
      concat_files(JS_ASSETS+'/client.app.js', app_files.flatten)
      
      #TODO: Generate file for jQuery: client/vendor/jquery/*.js (jquery, jquery-u, jquery plugins, ..) => jquery.all.js
      # Force load first jquery before jquery plugins
      concat_files(JS_ASSETS+'/jquery.js', Dir.glob(VENDOR_ROOT+'/jquery/*.js'))
      
      #TODO: Generate file for test: client.test.js
      #TODO: Generate #{plugin}.js for all client/vendor/#{plugin}/*.js
      #TODO: Compress!!!
         # http://blog.jcoglan.com/2009/02/22/packr-31-improved-compression-and-private-variable-support/
         # http://synthesis.sbecker.net/pages/asset_packager
         # http://www.crockford.com/javascript/jsmin.html
      #TODO: Some jquery plugins need some css. Make css work
    end
  private
    def self.concat_files(to, files)
      File.open(to,'w') do |new_file|
        files.each do |from_file|
          new_file.write File.read(from_file)
        end
        new_file.close
      end
    end
    
    
  end
  
end
