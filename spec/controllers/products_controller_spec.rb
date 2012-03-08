require 'spec_helper'
require "cancan/matchers"

describe ProductsController do
  render_views

  def valid_session
    {}
  end

  ability_init

  describe "GET show" do

    before(:each) do
      @ability.can :read, Product
      @product = Factory(:product)
    end

    it "should be successful" do
      get :show, id: @product
      response.should be_success
    end

    it "should assign the requested product as @product" do
      get :show, {id: @product}, valid_session
      assigns(:product).should eq(@product)
    end

    it "should show the right information" do
      get :show, {id: @product}, valid_session
      response.should contain(@product.title)
      response.should contain(@product.description)
      response.should have_selector('.show') do |show|
        show.should have_selector('img', count: @product.images.count)
      end
      response.should contain(@product.price.to_s)
    end

    it "should redirect with alert to the store when invalid id was taken" do
      get :show, {id: "invalid_id"}, valid_session
      response.should redirect_to(store_url)
      flash[:alert].should_not be_empty
    end
  end
end
