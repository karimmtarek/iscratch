require "application_responder"

class ApplicationController < ActionController::API
  # include ActionController::MimeResponds

  # include ActionController::RespondWith
  include ActionController::ImplicitRender
  include ActionController::StrongParameters

  self.responder = ApplicationResponder
  respond_to :json

end
