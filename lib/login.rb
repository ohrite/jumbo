require 'sinatra/base'

class JumboLogin < Sinatra::Base
  enable :sessions
  
  get '/login' do
    haml :login
  end
  
  post '/login' do
    if params[:name] = 'doc' and params[:password] = 'meat'
      session['user_name'] = params[:name]
    else
      redirect '/login'
    end
  end
end
