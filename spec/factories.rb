FactoryGirl.define do

  factory :product do
    sequence(:title) { |v| "Programming Ruby Version #{v}" }
    description "Ruby is the most exciting dynamic language out there."
    image_url "ruby.png"
    price 49.50
  end

  factory :cart do
  end

  factory :line_item do
    product
    cart
  end
end
