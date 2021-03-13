class SalesController < ApplicationController

  get '/sales' do
    redirect_if_not_logged_in

    @sales = Sale.all
    erb :'sales/index'
  end

  get '/sales/new' do
    redirect_if_not_logged_in

    erb :'sales/new'
  end

  post '/sales' do
    redirect_if_not_logged_in

    if params[:amount] != ""
      @sale = Sale.create(title: params[:title], amount: params[:amount], user_id: current_user.id)
      flash[:message] = "Your sale has been added."
      redirect '/sales'
    else
      redirect '/sales/new'
    end
  end

  get '/sales/:id' do
    set_sale

    if logged_in?
      redirect_if_not_authorized(@sale)
      erb :'sales/show'
    else
      redirect_if_not_logged_in
    end
  end

  get '/sales/:id/edit' do
    set_sale

    if authorized_edit?(@sale)
      erb :'sales/edit'
    else 
      redirect_if_not_authorized(@sale)
    end
  end

  patch '/sales/:id' do
    set_sale
    redirect_if_not_logged_in

    if authorized_edit?(@sale) && params[:title] != "" && params[:amount] != ""
      @sale.update(title: params[:title], amount: params[:amount])
      flash[:message] = "Your sale information has been updated."
      redirect "/sales/#{@sale.id}"
    else
      redirect '/sales'
    end
  end

  delete '/sales/:id' do
    set_sale

    if authorized_edit?(@sale)
      @sale.destroy
      flash[:message] = "Your sale has been deleted."
      redirect '/sales'
    else
      redirect_if_not_authorized(@sale)
    end
  end

  private #only to be used within SalesController
  
  def set_sale
    @sale = Sale.find_by(params[:id])
  end

end
