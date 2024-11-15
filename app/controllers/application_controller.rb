class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name, :feasibility_threshold, :adjustment_delta,
                                             { feasibility_levels_attributes: %i[id title value linguistic] }])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:name, :feasibility_threshold, :adjustment_delta,
                                             { feasibility_levels_attributes: %i[id title value linguistic] }])
  end

  def set_locale
    locale = extract_locale_from_accept_language_header || I18n.default_locale
    I18n.locale = locale
  end

  def extract_locale_from_accept_language_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']

    return if accept_language.blank?

    locale = accept_language.scan(/^[a-z]{2}/).first

    # Fallback to default locale if the extracted locale is not supported
    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  rescue StandardError => e
    logger.error "Error extracting locale: #{e.message}"
    nil
  end
end
