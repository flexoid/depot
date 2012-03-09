class Comment < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy

  belongs_to :product
  belongs_to :user

  attr_accessible :text, :parent_id

  validates :text, :product_id, :user_id, presence: true
end
