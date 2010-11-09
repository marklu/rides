Rides::Application.routes.draw do
  root :to => 'people#index'
  get '/dashboard' => 'people#dashboard', :as => 'person_root'

  resources :vehicles, :except => [:index, :show]

  resources :trips do
    resources :arrangements, :only => [:index, :show]
  end

  devise_for :people, :skip => [:sessions, :registrations] do
    get '/signin' => 'devise/sessions#new', :as => 'new_person_session'
    post '/signin' => 'devise/sessions#create', :as => 'person_session'
    get '/signout' => 'devise/sessions#destroy', :as => 'destroy_person_session'

    get '/signup' => 'devise/registrations#new', :as => 'new_person_registration'
    post '/profile' => 'devise/registrations#create', :as => 'person_registration'
    get '/profile' => 'devise/registrations#edit', :as => 'edit_person_registration'
    put '/profile' => 'devise/registrations#update', :as => 'person_registration'
    delete '/profile' => 'devise/registrations#destroy', :as => 'person_registration'
  end
end