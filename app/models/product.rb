class Product < ActiveRecord::Base
  default_scope order(:id)

  has_many :line_items
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  attr_accessible :title, :description, :price, :images_attributes

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: {minimum: 10, too_short: 'must be at least 10 characters.' }

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.any?
        errors.add(:base, 'Line items with this product present')
        false
      end
    end
end
