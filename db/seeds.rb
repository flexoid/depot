data = [
  {
    product: {
      title: 'CoffeeScript',
      description:
        %{<p>
          CoffeeScript is JavaScript done right. It provides all of JavaScript's
 	  functionality wrapped in a cleaner, more succinct syntax. In the first
 	  book on this exciting new language, CoffeeScript guru Trevor Burnham
 	  shows you how to hold onto all the power and flexibility of JavaScript
 	  while writing clearer, cleaner, and safer code.
        </p>},
      price: 36.00
    },
    images: ['cs.jpg', 'cs2.png', 'cs3.jpg']
  },
  {
    product: {
      title: 'Programming Ruby 1.9',
      description:
        %{<p>
          Ruby is the fastest growing and most exciting dynamic language
          out there. If you need to get working programs delivered fast,
          you should add Ruby to your toolbox.
        </p>},
      price: 49.95
    },
    images: ['ruby.jpg', 'ruby2.jpg', 'ruby3.png']
  },
  {
    product: {
      title: 'Rails Test Prescriptions',
      description:
        %{<p>
           <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
           Rails applications, covering Test-Driven Development from both a
           theoretical perspective (why to test) and from a practical perspective
           (how to test effectively). It covers the core Rails testing tools and
           procedures for Rails 2 and Rails 3, and introduces popular add-ons,
           including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
        </p>},
      price: 34.95
    },
    images: ['rtp.jpg', 'rails2.jpg']
  },
  {
    product: {
      title: 'Head First Rails',
      description:
        %{<p>
          Ready to transport your web applications into the Web 2.0 era?
          <em>Head First Rails</em> takes your programming -- and
          productivity -- to the max. You'll learn everything from the
          fundamentals of Rails scaffolding to building customized interactive
          web apps using Rails' rich set of tools and the MVC framework.
        </p>},
      price: 54.99
    },
    images: []
  }
]

data.each do |record|
  Product.create!(record[:product].merge(images: record[:images].map { |image|
    Image.new(image: Pathname.new("app/assets/images/#{image}"))}), without_protection: true)
end


3.times do
  Cart.create!
end


line_items = [
  {product: Product.all[0], cart: Cart.all[0]},
  {product: Product.all[1], cart: Cart.all[1]},
  {product: Product.all[2], cart: Cart.all[2]},
  {product: Product.all[1], cart: Cart.all[0]},
  {product: Product.all[2], cart: Cart.all[1]}
]
line_items.each do |line_item_attr|
  line_item = LineItem.new(line_item_attr, without_protection: true)
  line_item.quantity = rand(1..3)
  line_item.save!
end


users = [
  {name: "John Smith", email: "john@example.com", password: "password", role: "user"},
  {name: "Michael Corleone", email: "michael@example.com", password: "password", role: "user"},
  {name: "Bruce Wayne", email: "bruce@example.com", password: "password", role: "user"},

  {name: "Admin", email: "admin@example.com", password: "password", role: "admin"}
]
users.each do |user|
  User.create!(user, without_protection: true)
end


# Orders
User.select { |user| user.role == "user" }.each do |user|
  rand(2..5).times do
    order = Order.create!({user: user,
                          address: "#{rand(10..999)} Some st., Somecity",
                          pay_type: Order::PAYMENT_TYPES.sample}, without_protection: true)
    rand(2..5).times do
      order.line_items << LineItem.create!({product: Product.all.sample}, without_protection: true)
    end
  end
end


# Comments
def createComment(product, user, parent = nil)
  comment = Comment.create!({
    text: parent.nil? ? "I'm #{user.name} and I think that #{product.title} is #{%w(good perfect bad horrible).sample}" :
      "I'm #{user.name} and I #{%w(agree disagree).sample} with #{parent.user.name}",
    product: product,
    user: user},
    without_protection: true
  )

  comment.move_to_child_of(parent) unless parent.nil?
end

Product.all.each do |product|
  User.all.each do |user|
    product.reload

    another_user_comments = product.comments.select { |comment| comment.user != user }
    another_user_comments.sample(another_user_comments.count / 2).each do |parent_comment|
      createComment(product, user, parent_comment)
    end

    createComment(product, user)
  end
end
