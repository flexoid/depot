require 'spec_helper'
require "cancan/matchers"

describe User do

  before(:each) do
    @attr = Factory.attributes_for :user
  end

  it "should create a new user given valid attr" do
    expect {
      User.create(@attr)
    }.to change(User, :count).by(1)
  end

  it "should require valid email" do
    User.new(@attr.merge(email: "")).should_not be_valid
    User.new(@attr.merge(email: "invalid_email")).should_not be_valid
  end

  it "should require unique email" do
    User.create!(@attr)
    User.new(@attr).should_not be_valid
  end

  it "should require name" do
    User.new(@attr.merge(name: "")).should_not be_valid
  end

  it "should require valid password" do
    User.new(@attr.merge(password: "")).should_not be_valid
    User.new(@attr.merge(password: "short")).should_not be_valid
  end

  it "should require valid role" do
    User.new(@attr.merge(role: ""), without_protection: true).should_not be_valid
    User.new(@attr.merge(role: "visitor"), without_protection: true).should_not be_valid
  end

  it "should protect role attribute from mass-assignment" do
    expect {
      User.new(@attr.merge(role: "admin"))
    }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should allow to change role attribute with access permission" do
    user = User.new
    user.accessible = [:role]
    user.update_attributes(@attr.merge(role: "admin")).should be_true
  end
end
