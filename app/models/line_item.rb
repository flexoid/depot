class LineItem < ActiveRecord::Base

  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true

  def total_price
    product_price * quantity
  end
end
