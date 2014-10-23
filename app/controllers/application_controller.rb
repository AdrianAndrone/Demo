class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  layout :layout_used


  protected

  def layout_used
    if devise_controller?
      'devise'
    else
      'application'
    end
  end


end
