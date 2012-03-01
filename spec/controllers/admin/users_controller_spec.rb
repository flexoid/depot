require 'spec_helper'

describe Admin::UsersController do

  def valid_session
    {}
  end

  ability_init

  describe "GET index" do

    before(:each) do
      @ability.can :read, User
      @users = FactoryGirl.create_list(:user, 3)
    end

    it "should assign all users as @users" do
      get :index, {}, valid_session
      assigns(:users).should eq(@users)
    end
  end

  describe "GET show" do

    before(:each) do
      @ability.can :read, User
      @user = Factory(:user)
    end

    it "assigns the requested user as @user" do
      get :show, {id: @user}, valid_session
      assigns(:user).should eq(@user)
    end
  end

  describe "GET new" do

    before(:each) do
      @ability.can :create, User
    end

    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do

    before(:each) do
      @ability.can :update, User
      @user = Factory(:user)
    end

    it "should assign the requested user as @user" do
      get :edit, {id: @user}, valid_session
      assigns(:user).should eq(@user)
    end
  end

  describe "POST create" do

    before(:each) do
      @ability.can :create, User
      @attr = Factory.attributes_for(:user)
    end

    describe "with valid params" do
      it "should create a new User" do
        expect {
          post :create, {user: @attr}, valid_session
        }.to change(User, :count).by(1)
      end

      it "should assign a newly created user as @user" do
        post :create, {user: @attr}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "should redirect to the created user" do
        post :create, {user: @attr}, valid_session
        response.should redirect_to [:admin, User.last]
      end
    end

    describe "with invalid params" do
      it "should assign a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {user: {}}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "should re-render the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {user: {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    before(:each) do
      @ability.can :update, User
      @user = Factory(:user)
    end

    describe "with valid params" do

      before(:each) do
        @attr = Factory.attributes_for(:user, email: "some_mail@mail.co.uk")
      end

      it "should update the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {id: @user, user: {'these' => 'params'}}, valid_session
      end

      it "should assign the requested user as @user" do
        put :update, {id: @user, user: @attr}, valid_session
        assigns(:user).should eq(@user)
      end

      it "should redirect to the user" do
        put :update, {id: @user, user: @attr}, valid_session
        response.should redirect_to [:admin, @user]
      end
    end

    describe "with invalid params" do

      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
      end

      it "should assign the user as @user" do
        put :update, {id: @user, user: {}}, valid_session
        assigns(:user).should eq(@user)
      end

      it "should re-render the 'edit' template" do
        put :update, {id: @user, user: {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @ability.can :destroy, User
      @user = Factory(:user)
    end

    it "destroys the requested user" do
      expect {
        delete :destroy, {id: @user}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "should redirect to the users list" do
      delete :destroy, {id: @user}, valid_session
      response.should redirect_to(admin_users_url)
    end
  end

end
