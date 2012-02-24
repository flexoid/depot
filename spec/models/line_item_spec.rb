require 'spec_helper'

describe LineItem do

  before(:each) do
    @attr = Factory.attributes_for :line_item
    @cart = Factory(:cart)
    @product = Factory(:product)
  end

  it "should create a new line_item given valid attr" do
    expect {
      LineItem.create(@attr.merge(cart: @cart, product: @product))
    }.to change(LineItem, :count).by(1)
  end

  it "should be associated with cart" do
    LineItem.new(@attr.merge(cart_id: nil)).should_not be_valid
  end

  it "should be associated with product" do
    LineItem.new(@attr.merge(product_id: nil)).should_not be_valid
  end
end
