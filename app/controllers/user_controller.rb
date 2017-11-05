class UserController < ApplicationController

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

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :profile_page
    #Technically, called erb :show
  end

#LOG IN FORM ----------------
  get '/login' do

  end
end
