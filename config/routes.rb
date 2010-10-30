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

  devise_for :people, :skip => [:sessions, :registration] do
    # Session routes for Authenticatable (default)
    #      new_person_session GET  /people/sign_in                    {:controller=>"devise/sessions", :action=>"new"}
    #          person_session POST /people/sign_in                    {:controller=>"devise/sessions", :action=>"create"}
    #  destroy_person_session GET  /people/sign_out                   {:controller=>"devise/sessions", :action=>"destroy"}

    get "/signin" => "devise/sessions#new", :as => "new_person_session"
    post "/signin" => "devise/sessions#create", :as => "person_session"
    get "/signout" => "devise/sessions#destroy", :as => "destroy_person_session"


    #     person_registration POST   /people(.:format)               {:action=>"create", :controller=>"devise/registrations"}
    # new_person_registration GET    /people/sign_up(.:format)       {:action=>"new", :controller=>"devise/registrations"}
    #edit_person_registration GET    /people/edit(.:format)          {:action=>"edit", :controller=>"devise/registrations"}
    #     person_registration PUT    /people(.:format)               {:action=>"update", :controller=>"devise/registrations"}
    #     person_registration DELETE /people(.:format)               {:action=>"destroy", :controller=>"devise/registrations"
    post "/people" => "devise/registrations#create", :as => "person_registration"
    get "/signup" => "devise/registrations#new", :as => "new_person_registration"
    get "/editprofile" => "devise/registrations#edit", :as => "edit_person_registration"
    put "/people" => "devise/registrations#put", :as => "person_registration"
    delete "/people" => "devise/registrations#destroy", :as => "person_registration"


    #         person_password POST   /people/password(.:format)      {:action=>"create", :controller=>"devise/passwords"}
    #     new_person_password GET    /people/password/new(.:format)  {:action=>"new", :controller=>"devise/passwords"}
    #    edit_person_password GET    /people/password/edit(.:format) {:action=>"edit", :controller=>"devise/passwords"}
    #         person_password PUT    /people/password(.:format)      {:action=>"update", :controller=>"devise/passwords"}

  end


  root :to => 'people#index'

  #  resources :people do
  #    resources :vehicles
  #  end
  #
  #  resources :trips do
  #    resources :arrangements
  #  end
end
