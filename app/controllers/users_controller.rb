class UsersController < ApplicationController

  get '/login' do
    #render login page
    erb :'users/login'
  end

  post '/login' do
    #create session for user
    @user = User.find_by(email: params[:email]) #find user
    
    #make sure the user-password combo is valid
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      # display error message to user, go back to login page
      flash[:message] = "There was an issue while logging you in. Please make sure you've entered your information correctly."
      redirect '/login'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  #add new user to DB
  post '/users' do
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id

      redirect "/users/#{@user.slug}"
    else
      # Add error message here
      flash[:message] = "There was an issue while creating your account. Please fill out all of the forms below."
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @sales = Sale.all
    erb :'users/dashboard'
  end

end
