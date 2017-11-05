require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do

    erb :index
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by(id: session[:id])
    end
  end
end
