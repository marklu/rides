require 'spec_helper'

describe "vehicles/new.html.erb" do
  before(:each) do
    assign(:vehicle, stub_model(Vehicle,
      :capacity => 1
    ).as_new_record)
  end

  it "renders new vehicle form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => vehicles_path, :method => "post" do
      assert_select "input#vehicle_capacity", :name => "vehicle[capacity]"
    end
  end
end
