require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PlatformsController do

  login_admin

  # This should return the minimal set of attributes required to create a valid
  # Platform. As you add validations to Platform, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
        :name => "TestPlatform"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlatformsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all platforms as @platforms" do
      platform = Platform.create! valid_attributes
      get :index, {}
      assigns(:platforms).should eq([platform])
    end
  end

  describe "GET show" do
    it "assigns the requested platform as @platform" do
      platform = Platform.create! valid_attributes
      get :show, {:id => platform.to_param}
      assigns(:platform).should eq(platform)
    end
  end

  describe "GET new" do
    it "assigns a new platform as @platform" do
      get :new, {}
      assigns(:platform).should be_a_new(Platform)
    end
  end

  describe "GET edit" do
    it "assigns the requested platform as @platform" do
      platform = Platform.create! valid_attributes
      get :edit, {:id => platform.to_param}
      assigns(:platform).should eq(platform)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Platform" do
        expect {
          post :create, {:platform => valid_attributes}
        }.to change(Platform, :count).by(1)
      end

      it "assigns a newly created platform as @platform" do
        post :create, {:platform => valid_attributes}
        assigns(:platform).should be_a(Platform)
        assigns(:platform).should be_persisted
      end

      it "redirects to the created platform" do
        post :create, {:platform => valid_attributes}
        response.should redirect_to(Platform.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved platform as @platform" do
        # Trigger the behavior that occurs when invalid params are submitted
        Platform.any_instance.stub(:save).and_return(false)
        post :create, {:platform => {}}
        assigns(:platform).should be_a_new(Platform)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Platform.any_instance.stub(:save).and_return(false)
        post :create, {:platform => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested platform" do
        platform = Platform.create! valid_attributes
        # Assuming there are no other platforms in the database, this
        # specifies that the Platform created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Platform.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => platform.to_param, :platform => {'these' => 'params'}}
      end

      it "assigns the requested platform as @platform" do
        platform = Platform.create! valid_attributes
        put :update, {:id => platform.to_param, :platform => valid_attributes}
        assigns(:platform).should eq(platform)
      end

      it "redirects to the platform" do
        platform = Platform.create! valid_attributes
        put :update, {:id => platform.to_param, :platform => valid_attributes}
        response.should redirect_to(platform)
      end
    end

    describe "with invalid params" do
      it "assigns the platform as @platform" do
        platform = Platform.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Platform.any_instance.stub(:save).and_return(false)
        put :update, {:id => platform.to_param, :platform => {}}
        assigns(:platform).should eq(platform)
      end

      it "re-renders the 'edit' template" do
        platform = Platform.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Platform.any_instance.stub(:save).and_return(false)
        put :update, {:id => platform.to_param, :platform => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested platform" do
      platform = Platform.create! valid_attributes
      expect {
        delete :destroy, {:id => platform.to_param}
      }.to change(Platform, :count).by(-1)
    end

    it "redirects to the platforms list" do
      platform = Platform.create! valid_attributes
      delete :destroy, {:id => platform.to_param}
      response.should redirect_to(platforms_url)
    end
  end

end
