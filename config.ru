# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
#run Rails.application
#if ENV['RAILS_RELATIVE_URL_ROOT']
#  map ENV['RAILS_RELATIVE_URL_ROOT'] do
#    run Rails.application
#  end
#else
#  run Rails.application
#end

#if ENV['RAILS_ENV'] != 'production'
#    run Rails.application
#else
    # production
    map '/taka' do
        run Rails.application
    end
#end