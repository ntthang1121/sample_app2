class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper

  private
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "page_application_controller.msg_danger"
    redirect_to login_url
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
