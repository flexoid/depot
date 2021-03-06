require 'spec_helper'

describe Cart do

  describe "line_items associations" do

    before(:each) do
      @cart = Factory(:cart)
      @line_items = FactoryGirl.create_list(:line_item, 3, cart: @cart)
    end

    it "should have the line_items attribute" do
      @cart.should respond_to(:line_items)
    end

    it "should have the right line_items" do
      @cart.line_items.should eq(@line_items)
    end

    it "should destroy associated line_items" do
      @cart.destroy
      @line_items.each do |line_item|
        LineItem.find_by_id(line_item).should be_nil
      end
    end

    it "should group equal products in one line_item" do
      product = Factory(:product)
      @cart.line_items.delete_all
      3.times do
        @cart.add_product(product).save!
      end
      @cart.save
      @cart.line_items.count.should eq(1)
    end
  end
end
