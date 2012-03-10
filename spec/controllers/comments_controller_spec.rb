require 'spec_helper'
require "cancan/matchers"

describe CommentsController do

  ability_init

  describe "GET 'new'" do

    before(:each) do
      @ability.can :create, Comment
      @ability.can :read, Product
      @product = Factory(:product)
    end

    it "returns http success" do
      get :new, {product_id: @product}
      response.should be_success
    end

    it "should assign a new comment as @comment" do
      get :new, {product_id: @product}
      assigns(:comment).should be_a_new(Comment)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @ability.can :create, Comment
      @ability.can :read, Product
      @user = Factory(:user)
      @controller.stub(:current_user).and_return(@user)
      @product = Factory(:product)
    end

    describe "with valid params" do

      before(:each) do
        @comment_attr = Factory.attributes_for(:comment)
      end

      it "should create a new comment" do
        expect {
          post :create, product_id: @product.to_param, comment: @comment_attr
        }.to change(Comment, :count).by(1)
      end

      it "should assign a newly created comment as @comment" do
        post :create, product_id: @product.to_param, comment: @comment_attr
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "should redirect to the product" do
        post :create, product_id: @product.to_param, comment: @comment_attr
        comment = assigns(:comment)
        response.should redirect_to(action: 'show', controller: 'products',
                                    id: @product.to_param, anchor: "comment-#{comment.id}")
      end
    end

    describe "with invalid params" do

      it "should not create a new comment with invalid params" do
        expect {
          post :create, product_id: @product.to_param, comment: nil
        }.not_to change(Product, :count)
      end

      it "should re-render the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, product_id: @product.to_param
        response.should render_template("new")
      end
    end
  end

end
