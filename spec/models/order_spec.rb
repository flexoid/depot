require 'spec_helper'

describe Order do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:address)
    should allow_mass_assignment_of(:pay_type)

    should_not allow_mass_assignment_of(:user_id)
  end

  it "should create a new order given valid attr" do
    expect {
      Factory(:order)
    }.to change(Order, :count).by(1)
  end

  it "should be associated with user" do
    Factory.build(:order, user_id: nil).should_not be_valid
  end

  it "should have address" do
    Factory.build(:order, address: "").should_not be_valid
  end

  it "should have valid pay type" do
    Factory.build(:order, pay_type: "").should_not be_valid
    Factory.build(:order, pay_type: "NotValidPaymentType").should_not be_valid
  end
end
