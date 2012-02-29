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

  factory :user do
    sequence(:name) { |v| "User #{v}" }
    sequence(:email) { |v| "user#{v}@mail.com" }
    password Array.new(8) { Random.rand(0..9) }.join
  end
end
