class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :set_locale
  
  # Set current locale based on browser settings
  def set_locale
  
    # params[:preferred_language_from] = request.preferred_language_from([:en])
    # # nil
    # 
    # params[:available_locales] = I18n.available_locales
    # # [:en, :no, :de]
    # 
    # params[:locale] = request.compatible_language_from(I18n.available_locales)
    # # nil
    # 
    # params[:user_preferred_languages] = request.user_preferred_languages
    # # ["en-US"]
    # 
    # request.user_preferred_languages
    # # => [ 'en-GB']
    # 
    # available = ["en", "en-GB"]
    # params[:test] = request.compatible_language_from(available)
    
    I18n.locale = request.compatible_language_from(I18n.available_locales) unless params[:locale]
    
  end
  
  # Set locale option on all urls
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end
