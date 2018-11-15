class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def login!(user)
    self.session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token]) 
    #current_user ||= User.find_by_id(session[:user])
  end
  
  def logout!
    self.session[:session_token] = nil
  end
end
