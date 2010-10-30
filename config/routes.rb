Rides::Application.routes.draw do
=begin
    * Home (/)
    * Login (/signin) (DEVISE)
    * Register (/signup) (DEVISE)
    *

      Dashboard (/dashboard)
          o Create Trip (/trips/create)
          o Trip History (/trips/history
          o Edit Profile (/profile) (vehicles are shown here) (DEVISE)
          o Add Vehicle (/vehicles/add)
    *

      Trip Info (/trips/:id)
          o All Trip Arrangements (Trip Organizer) (/trips/:id/arrangements)
          o Join Trip (/trips/:id/join)
          o Trip Participants (/trips/:id/participants)
                + Invite Participant (not yet)
=end

  devise_for :people do
    get "/signin" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/signup" => "devise/registrations#new"
  end

=begin
  # Session routes for Authenticatable (default)
  #      new_person_session GET  /people/sign_in                    {:controller=>"devise/sessions", :action=>"new"}
  match '/signin' => 'devise/sessions#new', :as => :new_person_session, :via => "get"
  #          person_session POST /people/sign_in                    {:controller=>"devise/sessions", :action=>"create"}
  match '/signin' => 'devise/sessions#create', :as => :person_session, :via => "post"
  #  destroy_person_session GET  /people/sign_out                   {:controller=>"devise/sessions", :action=>"destroy"}
  match '/signout' => 'devise/sessions#destroy', :as => :destroy_person_session, :via => "get"


  # # Password routes for Recoverable, if person model has :recoverable configured
  #     new_person_password GET  /people/password/new(.:format)     {:controller=>"devise/passwords", :action=>"new"}
  match '/newpassword' => 'devise/passwords#new', :as => :new_person_password, :via => "get"
  #    edit_person_password GET  /people/password/edit(.:format)    {:controller=>"devise/passwords", :action=>"edit"}
  match '/changepassword' => 'devise/passwords#edit', :as => :edit_person_password, :via => "get"
  #         person_password PUT  /people/password(.:format)         {:controller=>"devise/passwords", :action=>"update"}
  match '/password' => 'devise/passwords#edit', :as => :person_password, :via => "put"
  #                       POST /people/password(.:format)         {:controller=>"devise/passwords", :action=>"create"}
  match '/password' => 'devise/passwords#create', :as => :person_password, :via => "post"
=end
  # # Confirmation routes for Confirmable, if person model has :confirmable configured
  # JKU: I don't think we need Confirmable.
  # new_person_confirmation GET  /people/confirmation/new(.:format) {:controller=>"devise/confirmations", :action=>"new"}
  #     person_confirmation GET  /people/confirmation(.:format)     {:controller=>"devise/confirmations", :action=>"show"}
  #                       POST /people/confirmation(.:format)     {:controller=>"devise/confirmations", :action=>"create"}



  #  devise_for :people, :path_names => { :sign_up => "new"}

  root :to => 'people#index'

  #  resources :people do
  #    resources :vehicles
  #  end
  #
  #  resources :trips do
  #    resources :arrangements
  #  end
end
