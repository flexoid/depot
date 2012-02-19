require 'spec_helper'

describe LineItem do

  before(:each) do
    @attr = Factory.attributes_for :line_item
    @cart = Factory(:cart)
    @product = Factory(:product)
  end

  it "should create a new line_item given valid attr" do
    LineItem.create!(@attr.merge(cart_id: @cart, product_id: @product))
  end

  it "should be associated with cart" do
    LineItem.new(@attr.merge(cart_id: nil)).should_not be_valid
  end

  it "should be associated with product" do
    LineItem.new(@attr.merge(product_id: nil)).should_not be_valid
  end
end
