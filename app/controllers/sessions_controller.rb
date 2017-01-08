class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:password] == "sss"
      session[:user_id] = 1
      redirect_to :controller => 'messages', :action => 'index'
    elsif params[:password] == "uuu"
      session[:user_id] = 2
      redirect_to :controller => 'messages', :action => 'index'
    elsif params[:password] == "aaa"
      session[:user_id] = 3
      redirect_to :controller => 'messages', :action => 'index'
    elsif params[:password] == "uuuaaa"
      session[:user_id] = 4
      redirect_to :controller => 'messages', :action => 'index'
    else
      #session[:user_id] = nil
      session.delete(:user_id)
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
      #session[:user_id] = nil
      session.delete(:user_id)
      redirect_to :controller => 'messages', :action => 'index'
  end
end
