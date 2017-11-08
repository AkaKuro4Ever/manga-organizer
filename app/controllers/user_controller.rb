require 'sinatra/base'
require 'rack-flash'
class UserController < ApplicationController
use Rack::Flash

#SIGN UP FORM ----------------
  get '/signup' do

    erb :'user/signup'
  end

  get '/users/error/1' do

    erb :error_signup
  end

  get '/users/error/2' do

    erb :error_login
  end

  post '/signup' do
    if params[:user][:username] == "" || params[:user][:password] == "" || params[:user][:email] == ""
      redirect "/users/error/1"
    else
      @user = User.new(username:  params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      @user.save #user.save only authenticates a password is not an empty string, not the username or email
      session[:id] = @user.id
      redirect to "/users/#{@user.id}"
    end
  end

  #SEE USER PROFILE PAGE -----------
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if logged_in? && current_user == @user
      erb :'user/profile_page'
      #Technically, called erb :show
    else
      erb :'user/show_outsiders'
    end
  end

#LOG IN FORM ----------------
  get '/login' do

    erb :'user/login'
  end

  post '/login' do
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
        session[:id] = @user.id
        redirect "/users/#{@user.id}"
    else
      redirect '/users/error/2'
    end
  end

  #EDITING USER ACCOUNT'S BOOK COLLECTION --
  get '/users/:id/edit' do

    @user = User.find_by(id: params[:id])
    erb :'user/edit'
  end

  patch '/users/:id/edit' do
    @user = User.find_by(id: params[:id])
    #Make sure to check that someone else cannot edit this!
    params[:manga][:books].each {|book|
      @user.books.delete(book)}

    redirect to "/users/#{@user.id}"
  end

  #LOGOUT ----------
  get '/logout' do
    session.clear
    redirect '/'
  end
end
