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
      redirect "/signup" #CAN WE DO FLASH AND NOT RELOAD SIGNUP PAGE? or RELOAD WITH SAME INFO?
    else
      @user = User.new(username:  params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      @user.save
      session[:id] = @user.id
      redirect to "/users/#{@user.id}"
    end
  end

#THINGS TO BE DONE:
#In signup - make sure that people with the same email cannot sign up.

  get '/users/:id' do
    #THINGS TO BE DONE:
    #profile pg can only be seen when logged in
    #profile pg can only be seen if person logged in is the user of that profile page
    #create a functioning logout button
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

  end
end
