class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  attr_accessible :text

  validates :text, :product_id, :user_id, presence: true
end
