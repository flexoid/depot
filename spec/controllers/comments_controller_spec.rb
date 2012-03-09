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
      get 'new', {product_id: @product}
      puts response.body
      response.should be_success
    end

    it "the rest of tests"
  end

  describe "POST 'create'" do

    before(:each) do
      @ability.can :create, Comment
    end

    it "the rest of tests"
  end

end
