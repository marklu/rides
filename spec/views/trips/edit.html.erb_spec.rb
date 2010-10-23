require 'spec_helper'

describe "trips/edit.html.erb" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :new_record? => false,
      :location => "MyString"
    ))
  end

  it "renders the edit trip form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => trip_path(@trip), :method => "post" do
      assert_select "input#trip_location", :name => "trip[location]"
    end
  end
end
