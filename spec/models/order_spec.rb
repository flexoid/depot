require 'spec_helper'

describe Order do

  before(:each) do
    @attr = Factory.attributes_for :order
  end

  it "should create a new order given valid attr" do
    @user = Factory(:user)
    expect {
      Order.create(@attr.merge(user: @user))
    }.to change(Order, :count).by(1)
  end

  it "should be associated with user" do
    Order.new(@attr.merge(user_id: nil)).should_not be_valid
  end

  it "should have address" do
    Order.new(@attr.merge(address: "")).should_not be_valid
  end

  it "should have valid pay type" do
    Order.new(@attr.merge(pay_type: "")).should_not be_valid
    Order.new(@attr.merge(pay_type: "NotValidPaymentType")).should_not be_valid
  end
end
