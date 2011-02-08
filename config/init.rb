require 'rubygems'
require 'bundler'

Bundler.require

# Set Sinatra's variables
set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
set :app_file, File.expand_path(File.join(Sinatra::Application.root, 'jumbo.rb'))
set :views, File.expand_path(File.join(Sinatra::Application.root, 'app', 'views'))
p "setting views to #{File.expand_path(File.join(Sinatra::Application.root, 'app', 'views'))}"
set :public, 'public'
set :haml, :format => :html5

p "set views to #{Sinatra::Application.views}"

# Configure Compass
configure do
  Compass.add_project_configuration(File.expand_path(File.join(Sinatra::Application.root, 'compass.rb')))
end

Dir[File.join(Sinatra::Application.root, 'lib', '*.rb')].each do |file|
  require File.expand_path(file)
end
