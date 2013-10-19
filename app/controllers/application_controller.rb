class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Mobylette::RespondToMobileRequests
  protect_from_forgery with: :exception
  #before_filter :prepare_for_mobile

  #def prepare_for_mobile  
  #  session[:mobile_param] = params[:mobile] if params[:mobile]  
  #  #request.format = :mobile# if mobile_device?  
  #  request.format = :html# if mobile_device?  
  #end  
end
