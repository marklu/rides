require 'spec_helper'

describe "trips/show.html.erb" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Location/)
  end
end
