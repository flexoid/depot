FactoryGirl.define do

  factory :product_without_images, class: Product do
    sequence(:title) { |v| "Programming Ruby Version #{v}" }
    description "Ruby is the most exciting dynamic language out there."
    price 49.50
  end

  factory :product, parent: :product_without_images do
    ignore do
      images_count 3
    end

    after_create do |product, evaluator|
      FactoryGirl.create_list(:image, evaluator.images_count, product: product)
    end
  end

  factory :image do
    image Rack::Test::UploadedFile.new("app/assets/images/ruby.jpg")
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

  factory :comment do
    product
    text "I'm #{user.name} and I approve this message"
    parent_id nil
  end
end
