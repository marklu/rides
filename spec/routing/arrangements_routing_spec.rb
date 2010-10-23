require "spec_helper"

describe ArrangementsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/arrangements" }.should route_to(:controller => "arrangements", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/arrangements/new" }.should route_to(:controller => "arrangements", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/arrangements/1" }.should route_to(:controller => "arrangements", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/arrangements/1/edit" }.should route_to(:controller => "arrangements", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/arrangements" }.should route_to(:controller => "arrangements", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/arrangements/1" }.should route_to(:controller => "arrangements", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/arrangements/1" }.should route_to(:controller => "arrangements", :action => "destroy", :id => "1")
    end

  end
end
