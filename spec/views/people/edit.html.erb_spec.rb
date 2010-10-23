require 'spec_helper'

describe "people/edit.html.erb" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :new_record? => false,
      :name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :address => "MyString"
    ))
  end

  it "renders the edit person form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => person_path(@person), :method => "post" do
      assert_select "input#person_name", :name => "person[name]"
      assert_select "input#person_email", :name => "person[email]"
      assert_select "input#person_phone", :name => "person[phone]"
      assert_select "input#person_address", :name => "person[address]"
    end
  end
end
