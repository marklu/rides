require 'spec_helper'

describe ArrangementsController do

  def mock_arrangement(stubs={})
    (@mock_arrangement ||= mock_model(Arrangement).as_null_object).tap do |arrangement|
      arrangement.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all arrangements as @arrangements" do
      Arrangement.stub(:all) { [mock_arrangement] }
      get :index
      assigns(:arrangements).should eq([mock_arrangement])
    end
  end

  describe "GET show" do
    it "assigns the requested arrangement as @arrangement" do
      Arrangement.stub(:find).with("37") { mock_arrangement }
      get :show, :id => "37"
      assigns(:arrangement).should be(mock_arrangement)
    end
  end

  describe "GET new" do
    it "assigns a new arrangement as @arrangement" do
      Arrangement.stub(:new) { mock_arrangement }
      get :new
      assigns(:arrangement).should be(mock_arrangement)
    end
  end

  describe "GET edit" do
    it "assigns the requested arrangement as @arrangement" do
      Arrangement.stub(:find).with("37") { mock_arrangement }
      get :edit, :id => "37"
      assigns(:arrangement).should be(mock_arrangement)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created arrangement as @arrangement" do
        Arrangement.stub(:new).with({'these' => 'params'}) { mock_arrangement(:save => true) }
        post :create, :arrangement => {'these' => 'params'}
        assigns(:arrangement).should be(mock_arrangement)
      end

      it "redirects to the created arrangement" do
        Arrangement.stub(:new) { mock_arrangement(:save => true) }
        post :create, :arrangement => {}
        response.should redirect_to(arrangement_url(mock_arrangement))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved arrangement as @arrangement" do
        Arrangement.stub(:new).with({'these' => 'params'}) { mock_arrangement(:save => false) }
        post :create, :arrangement => {'these' => 'params'}
        assigns(:arrangement).should be(mock_arrangement)
      end

      it "re-renders the 'new' template" do
        Arrangement.stub(:new) { mock_arrangement(:save => false) }
        post :create, :arrangement => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested arrangement" do
        Arrangement.should_receive(:find).with("37") { mock_arrangement }
        mock_arrangement.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :arrangement => {'these' => 'params'}
      end

      it "assigns the requested arrangement as @arrangement" do
        Arrangement.stub(:find) { mock_arrangement(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:arrangement).should be(mock_arrangement)
      end

      it "redirects to the arrangement" do
        Arrangement.stub(:find) { mock_arrangement(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(arrangement_url(mock_arrangement))
      end
    end

    describe "with invalid params" do
      it "assigns the arrangement as @arrangement" do
        Arrangement.stub(:find) { mock_arrangement(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:arrangement).should be(mock_arrangement)
      end

      it "re-renders the 'edit' template" do
        Arrangement.stub(:find) { mock_arrangement(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested arrangement" do
      Arrangement.should_receive(:find).with("37") { mock_arrangement }
      mock_arrangement.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the arrangements list" do
      Arrangement.stub(:find) { mock_arrangement }
      delete :destroy, :id => "1"
      response.should redirect_to(arrangements_url)
    end
  end

end
