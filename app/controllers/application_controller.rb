class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parse_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parse_locale) ?
      parse_locale.to_sym :
      nil
  end
end
