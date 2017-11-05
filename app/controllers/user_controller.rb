require 'sinatra/base'
require 'rack-flash'
class UserController < ApplicationController
use Rack::Flash

#SIGN UP FORM ----------------
  get '/signup' do

    erb :signup
  end

  post '/signup' do
    if params[:user][:username] == "" || params[:user][:password] == "" || params[:user][:email] == ""
      redirect "/signup"
    else
      @user = User.new(username:  params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      @user.save #user.save only authenticates a password is not an empty string, not the username or email
      session[:id] = @user.id
      redirect to "/users/#{@user.id}"
    end
  end

#THINGS TO BE DONE:
#In signup - make sure that people with the same email cannot sign up. (We're not doing this one for Sinatra project)
#Have some kind of message for wrong logins and sign

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if logged_in? && current_user == @user
      erb :profile_page
      #Technically, called erb :show
    else
      erb :show_outsiders
    end
  end

#LOG IN FORM ----------------
  get '/login' do

    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
        session[:id] = @user.id
        redirect "/users/#{@user.id}"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
