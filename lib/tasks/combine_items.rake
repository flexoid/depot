namespace :items do
  desc "Replace multiple items for a single product in a cart with a single item"
  task :combine => :environment do
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(product_id: product_id).destroy_all

          # replace with a single item
          cart.line_items.create!(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  desc "Split items with quantity>1 into multiple items"
  task :split => :environment do
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end

      # remove original item
      line_item.destroy
    end
  end
end
