require "spec_helper"

describe TripsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/trips" }.should route_to(:controller => "trips", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/trips/new" }.should route_to(:controller => "trips", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/trips/1" }.should route_to(:controller => "trips", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/trips/1/edit" }.should route_to(:controller => "trips", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/trips" }.should route_to(:controller => "trips", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/trips/1" }.should route_to(:controller => "trips", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/trips/1" }.should route_to(:controller => "trips", :action => "destroy", :id => "1")
    end

  end
end
