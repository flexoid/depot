require 'spec_helper'

describe ProductsController do

  def valid_session
    {}
  end

  describe "GET index" do

    before(:each) do
      @products = []
      3.times do
        @products << Factory(:product)
      end
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "assigns all products as @products" do
      get :index, {}, valid_session
      assigns(:products).should eq(@products)
    end
  end

  describe "GET show" do

    before(:each) do
      @product = Factory(:product)
    end

    it "should be successful" do
      get :show, id: @product
      response.should be_success
    end

    it "assigns the requested product as @product" do
      get :show, {id: @product}, valid_session
      assigns(:product).should eq(@product)
    end
  end

  describe "GET new" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "assigns a new product as @product" do
      get :new, {}, valid_session
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do

    before(:each) do
      @product = Factory(:product)
    end

    it "should be successful" do
      get :edit, id: @product
      response.should be_success
    end

    it "assigns the requested product as @product" do
      get :edit, {id: @product}, valid_session
      assigns(:product).should eq(@product)
    end
  end

  describe "POST create" do

    describe "with valid params" do

      before(:each) do
        @attr = Factory.attributes_for :product
      end

      it "creates a new Product" do
        expect {
          post :create, {product: @attr}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {product: @attr}, valid_session
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, {product: @attr}, valid_session
        response.should redirect_to(Product.last)
      end
    end

    describe "with invalid params" do

      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
      end

      it "assigns a newly created but unsaved product as @product" do
        post :create, {product: {}}, valid_session
        assigns(:product).should be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {product: {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do

      before(:each) do
        @product = Factory(:product)
        @attr = Factory.attributes_for(:product, description: "Some description")
      end

      it "updates the requested product" do
        Product.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {id: @product, product: {'these' => 'params'}}, valid_session
      end

      it "assigns the requested product as @product" do
        put :update, {id: @product, product: @attr}, valid_session
        assigns(:product).should eq(@product)
      end

      it "redirects to the product" do
        put :update, {id: @product, product: @attr}, valid_session
        response.should redirect_to(@product)
      end
    end

    describe "with invalid params" do

      before (:each) do
        @product = Factory(:product)
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
      end

      it "assigns the product as @product" do
        put :update, {id: @product, product: {}}, valid_session
        assigns(:product).should eq(@product)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @product, product: {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @product = Factory(:product)
    end

    it "destroys the requested product" do
      expect {
        delete :destroy, {id: @product}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, {id: @product}, valid_session
      response.should redirect_to(products_url)
    end
  end

end
