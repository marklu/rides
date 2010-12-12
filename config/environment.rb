# Load the rails application
require File.expand_path('../application', __FILE__)

ActionController::AbstractRequest.relative_url_root = "rideshare.heroku.com/"

# Initialize the rails application
Rides::Application.initialize!
