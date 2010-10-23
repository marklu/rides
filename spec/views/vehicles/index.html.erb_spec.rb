require 'spec_helper'

describe "vehicles/index.html.erb" do
  before(:each) do
    assign(:vehicles, [
      stub_model(Vehicle,
        :capacity => 1
      ),
      stub_model(Vehicle,
        :capacity => 1
      )
    ])
  end

  it "renders a list of vehicles" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
