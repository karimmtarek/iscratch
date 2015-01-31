require "application_responder"

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # include ActionController::MimeResponds
  # include ActionController::StrongParameters
  include ActionController::ImplicitRender

  self.responder = ApplicationResponder
  respond_to :json

  def require_signin
    unless current_user
      redirect_to signin_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_path
    end
  end

end
