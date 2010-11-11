require "spec_helper"

describe "Routes" do
  context "Home" do
    it "routes GET / to people#index" do
      {:get => "/"}.should route_to(:controller => "people", :action => "index")
    end
  end

  context "Login" do
    it "routes GET /signin to devise/sessions#new" do
      {:get => "/signin"}.should route_to(:controller => "devise/sessions", :action => "new")
    end

    it "routes POST /signin to devise/sessions#create" do
      {:post => "/signin"}.should route_to(:controller => "devise/sessions", :action => "create")
    end

    it "routes GET /signout to devise/sessions#destroy" do
      {:get => "/signout"}.should route_to(:controller => "devise/sessions", :action => "destroy")
    end
  end

  context "Register" do
    it "routes GET /signup to devise/registrations#new" do
      {:get => "/signup"}.should route_to(:controller => "devise/registrations", :action => "new")
    end

    it "routes POST /signup to devise/registrations#create" do
      {:post => "/signup"}.should route_to(:controller => "devise/registrations", :action => "create")
    end
  end

  context "Dashboard" do
    it "routes GET /dashboard to people#dashboard" do
      {:get => "/dashboard"}.should route_to(:controller => "people", :action => "dashboard")
    end

    context "Edit Profile" do
      it "routes GET /profile to devise/registrations#edit" do
        {:get => "/profile"}.should route_to(:controller => "devise/registrations", :action => "edit")
      end

      it "routes PUT /profile to devise/registrations#update" do
        {:put => "/profile"}.should route_to(:controller => "devise/registrations", :action => "update")
      end

      it "routes DELETE /profile to devise/registrations#destroy" do
        {:delete => "/profile"}.should route_to(:controller => "devise/registrations", :action => "destroy")
      end

      context "Add Vehicle" do
        it "routes GET /vehicles/new to vehicles#new" do
          {:get => "/vehicles/new"}.should route_to(:controller => "vehicles", :action => "new")
        end

        it "routes POST /vehicles to vehicles#create" do
          {:post => "/vehicles"}.should route_to(:controller => "vehicles", :action => "create")
        end
      end

      context "Manage Vehicle" do
        it "routes GET /vehicles/1/edit to vehicles#edit" do
          {:get => "/vehicles/1/edit"}.should route_to(:controller => "vehicles", :action => "edit", :id => "1")
        end

        it "routes PUT /vehicles/1 to vehicles#update" do
          {:put => "/vehicles/1"}.should route_to(:controller => "vehicles", :action => "update", :id => "1")
        end

        it "routes DELETE /vehicles/1 to vehicles#destroy" do
          {:delete => "/vehicles/1"}.should route_to(:controller => "vehicles", :action => "destroy", :id => "1")
        end
      end
    end

    context "Plan Trip" do
      it "routes GET /trips/new to trips#new" do
        {:get => "/trips/new"}.should route_to(:controller => "trips", :action => "new")
      end

      it "routes POST /trips to trips#create" do
        {:post => "/trips"}.should route_to(:controller => "trips", :action => "create")
      end
    end

    context "Trip History" do
      it "routes GET /trips to trips#index" do
        {:get => "/trips"}.should route_to(:controller => "trips", :action => "index")
      end
    end
  end

  context "Trip Info" do
    it "routes GET /trips/1 to trips#show" do
      {:get => "trips/1"}.should route_to(:controller => "trips", :action => "show", :id => "1")
    end

    context "All Trip Arrangements" do
      it "routes GET /trips/1/arrangements to arrangements#index" do
        {:get => "/trips/1/arrangements"}.should route_to(:controller => "arrangements", :action => "index", :trip_id => "1")
      end
    end

    context "Trip Participants" do
      it "routes GET /trips/1/participants to trips#participants"
    end

    context "Join Trip" do
      it "routes POST /trips/1/participants to trips#join"
    end

    context "Invite Participants" do
      it "routes GET ... to ... "
      it "routes POST ... to ..."
    end
  end
end