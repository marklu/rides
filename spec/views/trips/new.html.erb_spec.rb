require 'spec_helper'

describe "trips/new.html.erb" do
  before(:each) do
    assign(:trip, stub_model(Trip,
      :location => "MyString"
    ).as_new_record)
  end

  it "renders new trip form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => trips_path, :method => "post" do
      assert_select "input#trip_location", :name => "trip[location]"
    end
  end
end
