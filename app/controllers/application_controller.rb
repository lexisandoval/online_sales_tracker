require "./config/environment"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions                # session implementation here, creates server-side object (hash) that persists
		set :session_secret, "asdfghj"  # user data so the user doesn't have to keep logging in
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :index
    end
  end

  helpers do
    def current_user
      # assigns current user once, won't call to database more than once
      @current_user ||= User.find_by(id: session[:user_id]) # session is set here from '/login'
    end

    def logged_in?
      !!current_user #truthy value of current user object
    end

    def total_revenue(user)
      total = sprintf '%.2f', user.sales.sum(:amount)
    end

    def authorized_edit?(sale)
      sale.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:error] = "You must be logged in to view this page."
        redirect '/'
      end
    end

    def redirect_if_not_authorized(sale)
      if !authorized_edit?(sale)
        flash[:error] = "You may only review your own sales."
        redirect '/'
      end
    end
  end
  
end