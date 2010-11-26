Rides::Application.routes.draw do
  root :to => 'people#index'
  get '/dashboard' => 'people#dashboard', :as => 'person_root'

  resources :vehicles, :except => [:index, :show]

  resources :trips do
    post :invite, :on => :member, :as => 'invite'
    get :invitees, :on => :member, :as => 'invitees'
    get :join, :on => :member, :as => 'join'
    get :participants, :on => :member, :as => 'participants'
    delete '/participants' => 'trips#leave', :on => :member, :as => 'leave'
    resources :arrangements, :only => [:index, :show] do
      post :generate, :on => :collection
    end
    get :manage, :on => :member, :as => 'manage'

  end

  devise_for :people, :skip => [:sessions, :registrations] do
    get '/signin' => 'devise/sessions#new', :as => 'new_person_session'
    post '/signin' => 'devise/sessions#create', :as => 'create_person_session'
    get '/signout' => 'devise/sessions#destroy', :as => 'destroy_person_session'

    get '/signup' => 'devise/registrations#new', :as => 'new_person_registration'
    post '/signup' => 'devise/registrations#create', :as => 'create_person_registration'
    get '/profile' => 'devise/registrations#edit', :as => 'edit_person_registration'
    put '/profile' => 'devise/registrations#update', :as => 'update_person_registration'
    delete '/profile' => 'devise/registrations#destroy', :as => 'destroy_person_registration'
  end
end
