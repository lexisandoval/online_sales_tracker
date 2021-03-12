class UsersController < ApplicationController

  get '/login' do
    #render login page
    erb :"users/login"
  end

  post '/login' do
    #create session for user
    @user = User.find_by(params[:username]) #find user
    
    #make sure the user-password combo is valid
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/users/#{@user.id}'
    else
      # display error message to user, go back to login page
    end
  end

  get '/signup' do
    erb :'users/new'
  end

  get '/users/:id' do
    erb :'users/profile'
  end

end
