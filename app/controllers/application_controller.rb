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
      !!current_user
    end

    def current_user #=> User Instance || nil
      # memoiaztion
      # if @current_user #=> nil
      #   @current_user
      # else
      #   @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
      # end
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
