class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  # Run set_locale before every controller
  before_filter :set_locale
  
  # Set current locale based on browser settings
  def set_locale    
    I18n.locale = request.compatible_language_from(I18n.available_locales) unless params[:locale]
  end
  
  # Set locale option on all urls
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end
