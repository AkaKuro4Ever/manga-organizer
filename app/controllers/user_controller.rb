class UserController < ApplicationController

#SIGN UP FORM ----------------
  get '/signup' do

    erb :signup
  end

  post '/signup' do
    if user[:username] == "" || user[:password] == "" || user[:email] == ""
      redirect "/signup" #CAN WE DO FLASH AND NOT RELOAD SIGNUP PAGE? or RELOAD WITH SAME INFO?
    else
    @user = User.new(username: user[:username], email: user[:email], password: user[:password])

    redirect to "/users/#{@user.id}"
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
