Facefind::Application.routes.draw do |map|
  
  # Scope including /locale
  scope "/:locale" do
    # Find profile route
    match '/find(.:format)/(:id)' => "profiles#find", :id => /.+/, :as => :find

    # Search route
    match '/search' => "profiles#search", :as => :search

    # About route
    match '/about' => "profiles#about", :as => :about
  end
  
  # Find profile route
  match '/(:locale/)find(.:format)/(:id)' => "profiles#find", :id => /.+/, :as => :find
  
  # Home route
  match '/:locale' => 'profiles#index', :as => :home
  
  # Root route
  root :to => "profiles#index"
end
