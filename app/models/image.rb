class Image < ActiveRecord::Base
  belongs_to :product

  image_accessor :image
  attr_accessible :image, :retained_image

  validates :image, presence: true
  validates_property :format, :of => :image, :in => [:jpg, :png, :gif],
    message: 'must be GIF, JPG or PNG image.'
end
