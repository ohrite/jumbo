require 'sinatra/base'
require 'sinatra/compass'

class JumboRenderers < Sinatra::Base
  register Sinatra::Compass
  
  get_compass("stylesheets")
end