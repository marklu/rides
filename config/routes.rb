Rides::Application.routes.draw do
  root :to => 'people#index'
  match '/dashboard', :via => :get, :to => 'people#dashboard', :as => 'person_root'

  resources :vehicles, :except => [:index, :show]

  resources :trips do
    match '/participants', :via => :get, :to => 'trips#participants', :on => :member, :as => 'participants'
    match '/invite', :via => :post, :to => 'trips#invite', :on => :member, :as => 'invite'
    match '/membership', :via => :get, :to => 'trips#manage_membership', :on => :member, :as => 'manage_membership'
    match '/join', :via => [:get, :post], :to => 'trips#join', :on => :member, :as => 'join'
    match '/leave', :via => [:get, :delete], :to => 'trips#leave', :on => :member, :as => 'leave'
    match '/vehicles', :via => :post, :to => 'trips#manage_vehicles', :on => :member, :as => 'manage_vehicles'

    resources :arrangements, :only => [:index] do
      match '/generate', :via => :post, :to => 'arrangements#generate', :on => :collection, :as => 'generate'
    end
  end

  devise_for :people, :skip => [:sessions, :registrations] do
    match '/signin', :via => :get, :to => 'devise/sessions#new', :as => 'new_person_session'
    match '/signin', :via => :post, :to => 'devise/sessions#create', :as => 'create_person_session'
    match '/signout', :via => :get, :to => 'devise/sessions#destroy', :as => 'destroy_person_session'

    match '/signup', :via => :get, :to => 'devise/registrations#new', :as => 'new_person_registration'
    match '/signup', :via => :post, :to => 'devise/registrations#create', :as => 'create_person_registration'

    match '/profile', :via => :get, :to => 'devise/registrations#edit', :as => 'edit_person_registration'
    match '/profile', :via => :put, :to => 'devise/registrations#update', :as => 'update_person_registration'
    match '/profile', :via => :delete, :to => 'devise/registrations#destroy', :as => 'destroy_person_registration'
  end
end
