class SalesController < ApplicationController

  get '/sales' do
    @sales = Sale.all
    erb :'sales/index'
  end

  get '/sales/new' do
    erb :'sales/new'
  end

  post '/sales' do
    if !logged_in?
      redirect '/'
    end

    if params[:amount] != ""
      @sale = Sale.create(title: params[:title], amount: params[:amount], user_id: current_user.id)
      redirect "sales/#{@sale.id}"
    else
      redirect '/sales/new'
    end
  end

  get '/sales/:id' do
    set_sale
    erb :'sales/show'
  end

  get '/sales/:id/edit' do
    set_sale
    if logged_in?
      if @sale.user == current_user
        erb :'sales/edit'
      else 
        redirect '/sales'
      end
    else
      redirect '/'
    end
  end

  patch '/sales/:id' do
    set_sale
    if logged_in?
      if @sale.user == current_user
        @sale.update(title: params[:title], amount: params[:amount])
        redirect "/sales/#{@sale.id}"
      else
        redirect '/sales'
      end
    else
      redirect '/'
    end
  end



  private #only to be used within SalesController
  
  def set_sale
    @sale = Sale.find_by(params[:id])
  end

end
