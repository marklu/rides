Rides::Application.routes.draw do
=begin
* Home (/)
* Login (/signin) (DEVISE)
* Register (/signup) (DEVISE)
* Dashboard (/dashboard)
  * Create Trip (/trips/create)
  * Trip History (/trips/history)
  * Edit Profile (/profile) (vehicles are shown here) (DEVISE)
  * Add Vehicle (/vehicles/add)
* Trip Info (/trips/:id)
  * All Trip Arrangements (Trip Organizer) (/trips/:id/arrangements)
  * Join Trip (/trips/:id/join)
  * Trip Participants (/trips/:id/participants)
    * Invite Participant (not yet)
=end
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

    #         person_password POST   /people/password(.:format)      {:action=>"create", :controller=>"devise/passwords"}
    #     new_person_password GET    /people/password/new(.:format)  {:action=>"new", :controller=>"devise/passwords"}
    #    edit_person_password GET    /people/password/edit(.:format) {:action=>"edit", :controller=>"devise/passwords"}
    #         person_password PUT    /people/password(.:format)      {:action=>"update", :controller=>"devise/passwords"}
  end

  root :to => 'trips#index'

  resources :vehicles
  
  resources :trips do
    resources :arrangements
  end
end
