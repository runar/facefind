Facefind::Application.routes.draw do |map|
  
  # Find profile route
  match '/find(.:format)/(:id)' => "profiles#find", :id => /.+/, :as => :find
  
  # Search route
  match '/search' => "profiles#search", :as => :search
  
  # About route
  match '/about' => "profiles#about", :as => :about
  
  # Root route
  root :to => "profiles#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
