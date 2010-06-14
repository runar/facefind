Facefind::Application.routes.draw do |map|
  
  # Find profile route
  match '/find(.:format)/(:id)' => "profiles#find", :id => /.+/, :as => :find
  
  # Search route
  match '/search' => "profiles#search", :as => :search
  
  # About route
  match '/about' => "profiles#about", :as => :about
  
  # Root route
  root :to => "profiles#index"
end
