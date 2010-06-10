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
    
  end

end
