require 'spec_helper'

describe Product do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:title)
    should allow_mass_assignment_of(:description)
    should allow_mass_assignment_of(:price)
    should allow_mass_assignment_of(:image)
    should allow_mass_assignment_of(:retained_image)
    should allow_mass_assignment_of(:remove_image)
  end

  it "shoult create a new product given valid attr" do
    expect {
      Factory(:product)
    }.to change(Product, :count).by(1)
  end

  it "should require a title" do
    Factory.build(:product, title: "").should_not be_valid
  end

  it "should require a description" do
    Factory.build(:product, description: "").should_not be_valid
  end

  it "should require image url" do
    Factory.build(:product, image: nil).should_not be_valid
  end

  it "should have image url in valid format" do
    Factory.build(:product, image: Pathname.new("pic.txt")).should_not be_valid
  end

  it "should have numerical price" do
    Factory.build(:product, price: "five").should_not be_valid
  end

  it "should have a price grater than 0.01" do
    Factory.build(:product, price: 0.001).should_not be_valid
  end

  it "should have unique title" do
    title = "Product title"
    Factory(:product, title: title)
    Factory.build(:product, title: title).should_not be_valid
  end

  it "should have the title at least 10 characters long" do
    Factory.build(:product, title: "7 chars").should_not be_valid
  end

  describe "line_items associations:" do

    before(:each) do
      @product = Factory(:product)
      @line_items = FactoryGirl.create_list(:line_item, 3, product: @product)
    end

    it "should have the line_items attribute" do
      @product.should respond_to(:line_items)
    end

    it "should have the right line_items" do
      @product.line_items.should eq(@line_items)
    end

    it "shouldn't be destroyed if has associated line items" do
      expect {
        @product.destroy
      }.not_to change(Product, :count)
    end
  end
end
