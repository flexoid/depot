require 'spec_helper'

describe LineItemsController do

  def valid_session
    {}
  end

  describe "GET index" do

    before(:each) do
      @line_items = FactoryGirl.create_list(:line_item, 3)
    end

    it "should assign all line_items as @line_items" do
      get :index, {}, valid_session
      assigns(:line_items).should eq(@line_items)
    end
  end

  describe "GET show" do

    before(:each) do
      @line_item = Factory(:line_item)
    end

    it "should assign the requested line_item as @line_item" do
      get :show, {id: @line_item}, valid_session
      assigns(:line_item).should eq(@line_item)
    end

    it "should redirect with notice to the line items list when invalid id was taken" do
      get :show, {id: "invalid_id"}, valid_session
      response.should redirect_to(line_items_url)
      flash[:notice].should_not be_empty
    end
  end

  describe "GET new" do

    it "should assign a new line_item as @line_item" do
      get :new, {}, valid_session
      assigns(:line_item).should be_a_new(LineItem)
    end
  end

  describe "GET edit" do

    before(:each) do
      @line_item = Factory(:line_item)
    end

    it "should assign the requested line_item as @line_item" do
      get :edit, {id: @line_item}, valid_session
      assigns(:line_item).should eq(@line_item)
    end

    it "should redirect with notice to the line items list when invalid id was taken" do
      get :edit, {id: "invalid_id"}, valid_session
      response.should redirect_to(line_items_url)
      flash[:notice].should_not be_empty
    end
  end

  describe "POST create" do

    describe "with valid params" do

      before(:each) do
        @product = Factory(:product)
      end

      it "should create a new LineItem" do
        expect {
          post :create, {product_id: @product}, valid_session
        }.to change(LineItem, :count).by(1)
      end

      it "should assign a newly created line_item as @line_item" do
        post :create, {product_id: @product}, valid_session
        assigns(:line_item).should be_a(LineItem)
        assigns(:line_item).should be_persisted
      end

      it "should redirect to the cart associated with created line_item" do
        post :create, {product_id: @product}, valid_session
        response.should redirect_to(LineItem.last.cart)
      end
    end

    describe "with invalid params" do

      it "should not create a )ew line_item with invalid product_id" do
        expect {
          post :create, {product_id: nil}, valid_session
        }.not_to change(Product, :count)
      end

      it "should re-render the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LineItem.any_instance.stub(:save).and_return(false)
        post :create, {product_id: nil}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do

      before(:each) do
        @line_item = Factory(:line_item)
        @attr = Factory.attributes_for(:line_item)
      end

      it "should update the requested line_item" do
        # Assuming there are no other line_items in the database, this
        # specifies that the LineItem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        LineItem.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {id: @line_item, line_item: {'these' => 'params'}}, valid_session
      end

      it "should assign the requested line_item as @line_item" do
        put :update, {id: @line_item, line_item: @attr}, valid_session
        assigns(:line_item).should eq(@line_item)
      end

      it "should redirect to the line_item" do
        put :update, {id: @line_item, line_item: @attr}, valid_session
        response.should redirect_to(@line_item)
      end
    end

    describe "with invalid params" do

      before(:each) do
        @line_item = Factory(:line_item)
        # Trigger the behavior that occurs when invalid params are submitted
        LineItem.any_instance.stub(:save).and_return(false)
      end

      it "should assign the line_item as @line_item" do
        put :update, {id: @line_item, line_item: {}}, valid_session
        assigns(:line_item).should eq(@line_item)
      end

      it "should re-render the 'edit' template" do
        put :update, {id: @line_item, line_item: {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @line_item = Factory(:line_item)
    end

    it "should destroy the requested line_item" do
      expect {
        delete :destroy, {id: @line_item}, valid_session
      }.to change(LineItem, :count).by(-1)
    end

    it "should redirect with notice to the cart to which the item belonged" do
      cart = @line_item.cart
      delete :destroy, {id: @line_item}, valid_session
      response.should redirect_to(cart_url(cart))
    end
  end

end
