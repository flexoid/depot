require 'spec_helper'

describe LineItem do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:quantity)

    should_not allow_mass_assignment_of(:product_id)
    should_not allow_mass_assignment_of(:cart_id)
    should_not allow_mass_assignment_of(:order_id)
    should_not allow_mass_assignment_of(:product_price)
    should_not allow_mass_assignment_of(:cart)
  end

  it "should create a new line_item given valid attr" do
    expect {
      Factory(:line_item)
    }.to change(LineItem, :count).by(1)
  end

  it "should be associated with product" do
    Factory.build(:line_item, product_id: nil).should_not be_valid
  end
end
