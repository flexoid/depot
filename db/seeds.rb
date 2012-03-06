Product.create!(title: 'CoffeeScript',
  description:
    %{<p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript's
	functionality wrapped in a cleaner, more succinct syntax. In the first
	book on this exciting new language, CoffeeScript guru Trevor Burnham
	shows you how to hold onto all the power and flexibility of JavaScript
	while writing clearer, cleaner, and safer code.
      </p>},
  image: Pathname.new('app/assets/images/cs.jpg'),
  price: 36.00)

Product.create!(title: 'Programming Ruby 1.9',
  description:
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  image: Pathname.new('app/assets/images/ruby.jpg'),
  price: 49.95)

Product.create!(title: 'Rails Test Prescriptions',
  description:
    %{<p>
        <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
        Rails applications, covering Test-Driven Development from both a
        theoretical perspective (why to test) and from a practical perspective
        (how to test effectively). It covers the core Rails testing tools and
        procedures for Rails 2 and Rails 3, and introduces popular add-ons,
        including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
      </p>},
  image: Pathname.new('app/assets/images/rtp.jpg'),
  price: 34.95)

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
