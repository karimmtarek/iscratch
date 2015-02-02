require "application_responder"

class ApplicationController < ActionController::API
  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # include ActionController::MimeResponds
  # include ActionController::StrongParameters
  include ActionController::ImplicitRender

  self.responder = ApplicationResponder
  respond_to :json

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      #User.exists?(authentication_token: token)
      @current_user = User.find_by(authentication_token: token)
    end
  end

end
