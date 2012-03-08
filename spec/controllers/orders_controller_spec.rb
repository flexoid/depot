require 'spec_helper'
require 'cancan/matchers'

describe OrdersController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  ability_init

  describe "GET index" do

    before(:each) do
      @user = Factory(:user)
      @orders = FactoryGirl.create_list(:order, 3, user: @user)
      @orders += FactoryGirl.create_list(:order, 3)
    end

    context "with ability to read all orders" do

      before(:each) do
        @ability.can :read, Order
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

    context "with ability to read only own orders" do

      before(:each) do
        @ability.can :read, Order, user_id: @user.id
      end

      it "should assign user's orders as @orders" do
        get :index, {}, valid_session
        assigns(:orders).should eq(@orders.select { |order| order.user_id == @user.id })
      end
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

  describe "GET new" do

    before(:each) do
      @ability.can :create, Order
    end

    context "when cart isn't empty" do

      before(:each) do
        @cart = Factory(:cart)
        @product = Factory.create(:product)
        FactoryGirl.create_list(:line_item, 3, cart: @cart, product: @product)
      end

      it "should assign a new order as @order" do
        get :new, {}, valid_session.merge(cart_id: @cart)
        assigns(:order).should be_a_new(Order)
      end

      it "should render order creation page when cart isn't empty" do
        get :new, {}, valid_session.merge(cart_id: @cart)
        response.should render_template("new")
      end
    end

    context "when cart is empty" do

      it "should redirect to store with notice" do
        get :new, {}, valid_session
        response.should redirect_to(store_url)
        flash[:notice].should_not be_empty
      end
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

  describe "POST create" do

    before(:each) do
      @ability.can :create, Order
      @cart = Factory(:cart)
      @controller.stub(:current_cart).and_return(@cart)
    end

    context "when cart isn't empty" do

      before(:each) do
        @product = Factory.create(:product)
        FactoryGirl.create_list(:line_item, 3, cart: @cart, product: @product)
      end

      describe "with valid params" do

        before(:each) do
          @user = Factory(:user)
          @attr = Factory.attributes_for(:order)

          @controller.stub(:current_user).and_return(@user)
        end

        it "should create a new Order" do
          expect {
            post :create, {order: @attr}, valid_session
          }.to change(Order, :count).by(1)
        end

        it "should assign a newly created order as @order" do
          post :create, {order: @attr}, valid_session
          assigns(:order).should be_a(Order)
          assigns(:order).should be_persisted
        end

        it "should redirect to the store" do
          post :create, {order: @attr}, valid_session
          response.should redirect_to(store_url)
        end
      end

      describe "with invalid params" do

        it "should assign a newly created but unsaved order as @order" do
          # Trigger the behavior that occurs when invalid params are submitted
          Order.any_instance.stub(:save).and_return(false)
          post :create, {:order => {}}, valid_session
          assigns(:order).should be_a_new(Order)
        end

        it "should re-render the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Order.any_instance.stub(:save).and_return(false)
          post :create, {:order => {}}, valid_session
          response.should render_template("new")
        end
      end
    end

    context "with empty cart" do

      it "should redirect to the store with alert" do
        post :create, {}, valid_session
        response.should redirect_to(store_url)
        flash[:alert].should_not be_empty
      end
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
        response.should redirect_to(@order)
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
      response.should redirect_to(orders_url)
    end
  end

end
