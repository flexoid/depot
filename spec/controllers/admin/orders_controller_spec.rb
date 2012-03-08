require 'spec_helper'
require 'cancan/matchers'

describe Admin::OrdersController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  ability_init

  before(:each) do
    @ability.can :admin, :all
  end

  describe "GET index" do

    before(:each) do
      @ability.can :read, Order

      @user = Factory(:user)
      @orders = FactoryGirl.create_list(:order, 3, user: @user)
      @orders += FactoryGirl.create_list(:order, 3)
    end

    it "should assign all orders as @orders" do
      get :index, {}, valid_session
      assigns(:orders).should eq(@orders)
    end

    it "should render index page" do
      get :index, {}, valid_session
      response.should render_template('index')
    end
  end

  describe "GET show" do

    before(:each) do
      @ability.can :read, Order
      @order = Factory.create(:order)
    end

    it "should assign the requested order as @order" do
      get :show, {id: @order.to_param}, valid_session
      assigns(:order).should eq(@order)
    end

    it "should render show page" do
      get :show, {id: @order.to_param}, valid_session
      response.should render_template('show')
    end
  end

  describe "GET edit" do

    before(:each) do
      @ability.can :update, Order
      @order = Factory.create(:order)
    end

    it "should assign the requested order as @order" do
      get :edit, {id: @order.to_param}, valid_session
      assigns(:order).should eq(@order)
    end

    it "should render edit page" do
      get :edit, {id: @order.to_param}, valid_session
      response.should render_template('edit')
    end
  end

  describe "PUT update" do

    before(:each) do
      @ability.can :update, Order
      @order = Factory(:order)
    end

    describe "with valid params" do

      before(:each) do
        @attr = Factory.attributes_for(:order, address: "Some address")
      end

      it "should update the requested order" do
        # Assuming there are no other orders in the database, this
        # specifies that the Order created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Order.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {id: @order.to_param, order: {'these' => 'params'}}, valid_session
      end

      it "should assign the requested order as @order" do
        put :update, {id: @order.to_param, order: @attr}, valid_session
        assigns(:order).should eq(@order)
      end

      it "should redirect to the order" do
        put :update, {id: @order.to_param, order: @attr}, valid_session
        response.should redirect_to [:admin, @order]
      end
    end

    describe "with invalid params" do

      it "should assign the order as @order" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {id: @order.to_param, order: {}}, valid_session
        assigns(:order).should eq(@order)
      end

      it "should re-render the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {id: @order.to_param, order: {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @ability.can :destroy, Order
      @order = Factory(:order)
    end

    it "should destroy the requested order" do
      expect {
        delete :destroy, {id: @order.to_param}, valid_session
      }.to change(Order, :count).by(-1)
    end

    it "should redirect to the orders list" do
      delete :destroy, {id: @order.to_param}, valid_session
      response.should redirect_to admin_orders_url
    end
  end

end
