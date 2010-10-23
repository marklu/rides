require 'spec_helper'

describe "arrangements/new.html.erb" do
  before(:each) do
    assign(:arrangement, stub_model(Arrangement).as_new_record)
  end

  it "renders new arrangement form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => arrangements_path, :method => "post" do
    end
  end
end
