# frozen_string_literal: true

class ApplicationController < ActionController::Base
  respond_to :html, :json
  before_action :authenticate_user!, :set_locale
  protect_from_forgery unless: -> { request.format.json? }

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :name, :language, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :name, :language, :current_password)
    end
  end

  private
  
  def set_locale
    parsed_locale = params[:locale]
    locale_to_set = I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : I18n.locale
    I18n.locale = locale_to_set
  end
end
