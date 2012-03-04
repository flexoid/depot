class LineItem < ActiveRecord::Base

  before_validation :set_product_price

  belongs_to :cart
  belongs_to :product
  belongs_to :order

  validates :product_id, :product_price, presence: true
  validates :product_price, numericality: { greater_than_or_equal_to: 0.01 }

  def total_price
    product_price * quantity
  end

  private

    def set_product_price
      self.product_price = product.price if !product_price && product
    end
end
