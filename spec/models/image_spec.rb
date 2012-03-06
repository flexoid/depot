require 'spec_helper'

describe Image do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:image)
    should allow_mass_assignment_of(:retained_image)

    should_not allow_mass_assignment_of(:product_id)
    should_not allow_mass_assignment_of(:image_uid)
  end

  it "shoult create a new image given valid attr" do
    expect {
      Factory(:image)
    }.to change(Image, :count).by(1)
  end

  it "should require valid image" do
    Factory.build(:image, image: nil).should_not be_valid
  end
end
