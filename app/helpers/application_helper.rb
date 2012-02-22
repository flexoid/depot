module ApplicationHelper

  def date_time
    DateTime.current.to_formatted_s(:long)
  end

  def thumbnail(product, geometry, image_class = nil)
    unless product.image.nil?
      link_to (image_tag product.image.thumb(geometry).url, class: image_class), product.image.url
    end
  end
end
