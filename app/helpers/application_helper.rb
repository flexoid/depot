module ApplicationHelper

  def date_time
    DateTime.current.to_formatted_s(:long)
  end

  def thumbnail(image, geometry, image_class = nil)
    link_to (image_tag image.thumb(geometry).url, class: image_class), image.url
  end

  def first_thumbnail(product, geometry, image_class = nil)
    if product.images.any?
      thumbnail(product.images.first.image, geometry, image_class)
    else
      image_tag '/assets/noimage.png'
    end
  end

  def cart_link
    link_to "Cart (#{pluralize(current_cart.total_count, 'item')})", cart_path(current_cart)
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
end
