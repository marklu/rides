require 'spec_helper'

describe "arrangements/index.html.erb" do
  before(:each) do
    assign(:arrangements, [
      stub_model(Arrangement),
      stub_model(Arrangement)
    ])
  end

  it "renders a list of arrangements" do
    render
  end
end
