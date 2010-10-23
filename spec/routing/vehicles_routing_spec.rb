require "spec_helper"

describe VehiclesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/vehicles" }.should route_to(:controller => "vehicles", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/vehicles/new" }.should route_to(:controller => "vehicles", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/vehicles/1" }.should route_to(:controller => "vehicles", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/vehicles/1/edit" }.should route_to(:controller => "vehicles", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/vehicles" }.should route_to(:controller => "vehicles", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/vehicles/1" }.should route_to(:controller => "vehicles", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/vehicles/1" }.should route_to(:controller => "vehicles", :action => "destroy", :id => "1")
    end

  end
end
