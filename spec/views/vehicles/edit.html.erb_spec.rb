require 'spec_helper'

describe "vehicles/edit.html.erb" do
  before(:each) do
    @vehicle = assign(:vehicle, stub_model(Vehicle,
      :new_record? => false,
      :capacity => 1
    ))
  end

  it "renders the edit vehicle form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => vehicle_path(@vehicle), :method => "post" do
      assert_select "input#vehicle_capacity", :name => "vehicle[capacity]"
    end
  end
end
