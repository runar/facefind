class ProfilesController < ApplicationController
  respond_to :html, :json, :only => :find
  
  # Count profiles in all actions, except search
  before_filter :count_profiles, :except => :search
  
  def index
  end
  
  def about
  end

  def search
    # Redirect to root path unless id exists
    redirect_to root_path and return unless params[:id]
    
    # Redirect to find action to show data
    redirect_to find_path(:id => params[:id])
  end
  
  def find
    # Redirect to root path unless id exists
    redirect_to root_path and return unless params[:id]
    
    # Find Facebook if from url (id param) by using regexes
    profile_id = case params[:id]
    when /[a-z\/:\.-]+\.fbcdn\.net\/[\w\/\-]+\/\w(\d+)_[\d\_]+.jpg\z/ then "#{$1}"
    when /[a-z\/:\.-]+\.fbcdn\.net\/[\w\/\-\.]+\/\d*_?\d+_(\d+)_\d+_[\d_]*\w.jpg\z/ then "#{$1}"
    when /[a-z\/:\.]*\.facebook\.com\/[\w\W]+\.php\?pid=\d+&id=(\d+)(&fbid=\d+)?\z/ then "#{$1}"
    
    # No matches, show error
    else
      handle_error(t('errors.wrong_format')) and return
    end
    
    # Parse Facebook Graph API with profile id
    uri = URI.parse('http://graph.facebook.com/' + profile_id)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    
    # Decode old JSON response as hash
    @result = ActiveSupport::JSON.decode(response.body)
    
    # Redirect to error page if invalid ID or none found
    handle_error(t('errors.not_found')) and return unless @result.respond_to?(:has_key?) and @result.has_key?("name")
    
    # Add Facebook link if not included in data fetched from API
    @result["link"] ||= profile_link_for(@result["id"])
    
    @profile = Profile.find_or_create_by_facebook_id(:facebook_id => @result['id'])
    
    # Respond!
    respond_with(@result)
  end
  
  private
  
  # Return link to Facebook profile based on id
  def profile_link_for(id)
    "http://facebook.com/profile.php?id=" + id
  end
  
  # Handle error based on requested format
  def handle_error(message)
    respond_to do |format|
      
      # HTML: Redirect to root with 404 and flash notice
      format.html { redirect_to home_path, :state => :not_found, :notice => message }
      
      # JSON: 404 and blank file
      format.json { render :json => message, :status => :not_found }
    end
  end
  
  # Count total profiles stored
  def count_profiles
    @total_profiles = Profile.count
  end

end
