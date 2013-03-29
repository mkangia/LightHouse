# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LightHouse::Application.initialize!
Delayed::Job.attr_accessible :priority, :payload_object, :handler, :run_at, :failed_at, :queue