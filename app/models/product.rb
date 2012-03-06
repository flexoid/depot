class Product < ActiveRecord::Base

  image_accessor :image

  has_many :line_items

  attr_accessible :title, :description, :price, :image, :retained_image, :remove_image

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: {minimum: 10, too_short: 'must be at least 10 characters.' }
  validates_property :format, :of => :image, :in => [:jpg, :png, :gif],
    message: 'must be GIF, JPG or PNG image.'

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.any?
        errors.add(:base, 'Line items with this product present')
        false
      end
    end
end
