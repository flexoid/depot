require 'spec_helper'

describe Comment do

  it "should respects mass-assignment security" do
    should allow_mass_assignment_of(:text)
    should allow_mass_assignment_of(:parent_id)

    should_not allow_mass_assignment_of(:user_id)
  end

  it "shoult create a new comment given valid attr" do
    expect {
      Factory(:comment)
    }.to change(Comment, :count).by(1)
  end

  it "should require a text" do
    Factory.build(:comment, text: "").should_not be_valid
  end

  it "should require a product_id" do
    Factory.build(:comment, product_id: nil).should_not be_valid
  end

  it "should require a user_id" do
    Factory.build(:comment, user_id: nil).should_not be_valid
  end

  describe "nested set" do

    before(:each) do
      @parent_comment = Factory(:comment)
      @child_comment = Factory(:comment, parent_id: @parent_comment.id)
      @parent_comment.reload
    end

    it "should create child comment" do
      @child_comment.is_descendant_of?(@parent_comment).should be_true
    end

    it "should destroy child comment when parent comment was destroyed" do
      @parent_comment.destroy
      expect {
        @child_comment.reload
      }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
