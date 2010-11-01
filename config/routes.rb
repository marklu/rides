Rides::Application.routes.draw do
  root :to => 'trips#index'

  devise_for :people, :skip => [:sessions, :registrations] do
    match '/trips' => 'trips#index', :as => 'person_root'

    get "/signin" => "devise/sessions#new", :as => "new_person_session"
    post "/signin" => "devise/sessions#create", :as => "person_session"
    get "/signout" => "devise/sessions#destroy", :as => "destroy_person_session"

    post "/people" => "devise/registrations#create", :as => "person_registration"
    get "/signup" => "devise/registrations#new", :as => "new_person_registration"
    get "/profile" => "devise/registrations#edit", :as => "edit_person_registration"
    put "/people" => "devise/registrations#update", :as => "person_registration"
    delete "/people" => "devise/registrations#destroy", :as => "person_registration"
  end

  resources :vehicles
  
  resources :trips do
    resources :arrangements
  end
end
