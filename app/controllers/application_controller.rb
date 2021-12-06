class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  def ensure_admin
    return if current_user.role.name == "admin"
    redirect_to root_path, alert: "You are not authorized for this action."
  end

  protected
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :surname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys:[:name, :surname, :email, :password, :current_password])
  end
end
