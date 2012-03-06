require 'spec_helper'
require "cancan/matchers"

describe User do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:email)
    should allow_mass_assignment_of(:name)
    should allow_mass_assignment_of(:password)
    should allow_mass_assignment_of(:password_confirmation)
    should allow_mass_assignment_of(:remember_me)

    should_not allow_mass_assignment_of(:role)
  end

  it "should create a new user given valid attr" do
    expect {
      Factory(:user)
    }.to change(User, :count).by(1)
  end

  it "should require valid email" do
    Factory.build(:user, email: "").should_not be_valid
    Factory.build(:user, email: "invalid_email").should_not be_valid
  end

  it "should require unique email" do
    email = "email@example.com"
    Factory(:user, email: email)
    Factory.build(:user, email: email).should_not be_valid
  end

  it "should require name" do
    Factory.build(:user, name: "").should_not be_valid
  end

  it "should require valid password" do
    Factory.build(:user, password: "").should_not be_valid
    Factory.build(:user, password: "short").should_not be_valid
  end

  it "should require valid role" do
    Factory.build(:user, role: "").should_not be_valid
    Factory.build(:user, role: "visitor").should_not be_valid
  end

  it "should allow to change role attribute with access permission" do
    user = Factory(:user)
    user.accessible = [:role]
    user.update_attributes(role: "admin").should be_true
  end
end
