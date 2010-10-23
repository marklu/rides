require 'spec_helper'

describe "people/new.html.erb" do
  before(:each) do
    assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :address => "MyString"
    ).as_new_record)
  end

  it "renders new person form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => people_path, :method => "post" do
      assert_select "input#person_name", :name => "person[name]"
      assert_select "input#person_email", :name => "person[email]"
      assert_select "input#person_phone", :name => "person[phone]"
      assert_select "input#person_address", :name => "person[address]"
    end
  end
end
