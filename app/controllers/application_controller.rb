class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |s| s.permit(:name, :bio, :email, :password, :posts_counter, :photo) }
    devise_parameter_sanitizer.permit(:account_update) do |s|
      s.permit(:name,
               :bio,
               :email,
               :password,
               :current_password,
               :photo)
    end
  end
end
