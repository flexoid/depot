FactoryGirl.define do

  factory :product do
    sequence(:title) { |v| "Programming Ruby Version #{v}" }
    description "Ruby is the most exciting dynamic language out there."
    image Rack::Test::UploadedFile.new("app/assets/images/ruby.jpg")
    price 49.50
  end

  factory :cart do
  end

  factory :line_item do
    product
    cart
    quantity Random.rand(1..3)
  end

  factory :user do |f|
    sequence(:name) { |v| "User #{v}" }
    sequence(:email) { |v| "user#{v}@example.com" }
    password "password"
  end

  factory :admin, parent: :user do |f|
    f.after_create do |user|
      user.role = "admin"
      user.save
    end
  end

  factory :order do
    user
    address "#{Random.rand(10..999)} Some st., Somecity"
    pay_type Order::PAYMENT_TYPES.sample
  end
end
