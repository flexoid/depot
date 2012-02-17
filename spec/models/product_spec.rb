require 'spec_helper'

describe Product do

  before(:each) do
    @attr = Factory.attributes_for :product
  end

  it "shoult create a new product given valid attr" do
    Product.create!(@attr)
  end

  it "should require a title" do
    Product.new(@attr.merge(title: "")).should_not be_valid
  end

  it "should require a description" do
    Product.new(@attr.merge(description: "")).should_not be_valid
  end

  it "should require image url" do
    Product.new(@attr.merge(image_url: "")).should_not be_valid
  end

  it "should have image url in valid format" do
    Product.new(@attr.merge(image_url: "...")).should_not be_valid
  end

  it "should have numerical price" do
    Product.new(@attr.merge(price: "five")).should_not be_valid
  end

  it "should have a price grater than 0.01" do
    Product.new(@attr.merge(price: 0.001)).should_not be_valid
  end

  it "should have unique title" do
    Product.create!(@attr)
    Product.new(@attr).should_not be_valid
  end
end
