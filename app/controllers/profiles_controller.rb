class ProfilesController < ApplicationController
  def index
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
    when /[a-z\/:\.-]+\.fbcdn\.net\/[\w\/\-]+\/\w(\d+)_[\d\_]+.jpg/ then "#{$1}"
    when /[a-z\/:\.-]+\.fbcdn\.net\/[\w\/\-\.]+\/\d*_?\d+_(\d+)_\d+_[\d_]*\w.jpg/ then "#{$1}"
    when /[a-z\/:\.]*\.facebook\.com\/[\w\W]+\.php\?pid=\d+&id=(\d+)(&fbid=\d+)?/ then "#{$1}"
    
    # No matches, show error
    else
      handle_error('Wrong format!') and return
    end
  end

end
