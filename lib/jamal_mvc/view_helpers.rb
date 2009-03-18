module JamalMVC
  module ViewHelpers
    def include_client_app
      #TODO: If env == develop check for timestamps to update
      JamalMVC::Rake.update_assets if RAILS_ENV == 'development'
      javascript_include_tag 'jquery','jamal','client.app'
    end
  end
end
