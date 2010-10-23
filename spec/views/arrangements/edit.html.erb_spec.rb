require 'spec_helper'

describe "arrangements/edit.html.erb" do
  before(:each) do
    @arrangement = assign(:arrangement, stub_model(Arrangement,
      :new_record? => false
    ))
  end

  it "renders the edit arrangement form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => arrangement_path(@arrangement), :method => "post" do
    end
  end
end
