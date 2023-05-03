# frozen_string_literal: true

class ApplicationController < ActionController::Base
  respond_to :html, :json
  before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :language, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :language, :current_password)
    end
  end
end
