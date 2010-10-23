require 'spec_helper'

describe "arrangements/show.html.erb" do
  before(:each) do
    @arrangement = assign(:arrangement, stub_model(Arrangement))
  end

  it "renders attributes in <p>" do
    render
  end
end
