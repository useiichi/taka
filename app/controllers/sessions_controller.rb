class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:password] == "ayu"
      session[:user_id] = 1
      redirect_to :controller => 'messages', :action => 'index' 
    elsif params[:password] == "ume"
      session[:user_id] = 2   
      redirect_to :controller => 'messages', :action => 'index' 
    elsif 
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end  
  end

  def destroy
      session[:user_id] = 0
      redirect_to :controller => 'messages', :action => 'index' 
  end
end
