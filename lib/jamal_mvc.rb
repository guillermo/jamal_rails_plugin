
# JamalMVC

module JamalMVC
  CLIENT_ROOT = RAILS_ROOT+'/client'
  VENDOR_ROOT = CLIENT_ROOT+'/vendor'
  CLIENT_APP  = CLIENT_ROOT+'/app'
  JAMAL_ROOT =  VENDOR_ROOT+'/jamal'
  JS_ASSETS = RAILS_ROOT+'/public/javascripts'
  autoload(:Rake, File.dirname(__FILE__)+'/jamal_mvc/rake.rb')
  autoload(:ViewHelpers,File.dirname(__FILE__)+'/jamal_mvc/view_helpers.rb' )
end