require 'spec_helper'

describe "trips/index.html.erb" do
  before(:each) do
    assign(:trips, [
      stub_model(Trip,
        :location => "Location"
      ),
      stub_model(Trip,
        :location => "Location"
      )
    ])
  end

  it "renders a list of trips" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
