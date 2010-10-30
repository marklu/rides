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

  devise_for :people, :skip => :sessions do
    get "/signin" => "devise/sessions#new", :as => "new_person_session"
    post "/signin" => "devise/sessions#create", :as => "person_session"
    get "/signout" => "devise/sessions#destroy", :as => "destroy_person_session"
    get "/signup" => "devise/registrations#new"
  end

=begin
  # Session routes for Authenticatable (default)
  #      new_person_session GET  /people/sign_in                    {:controller=>"devise/sessions", :action=>"new"}
  #          person_session POST /people/sign_in                    {:controller=>"devise/sessions", :action=>"create"}
  #  destroy_person_session GET  /people/sign_out                   {:controller=>"devise/sessions", :action=>"destroy"}

  # # Password routes for Recoverable, if person model has :recoverable configured
  #     new_person_password GET  /people/password/new(.:format)     {:controller=>"devise/passwords", :action=>"new"}
  #    edit_person_password GET  /people/password/edit(.:format)    {:controller=>"devise/passwords", :action=>"edit"}
  #         person_password PUT  /people/password(.:format)         {:controller=>"devise/passwords", :action=>"update"}
  #                       POST /people/password(.:format)         {:controller=>"devise/passwords", :action=>"create"}
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
