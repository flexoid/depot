Factory.define :product do |p|
  p.sequence(:title) { |v| "Programming Ruby Version #{v}" }
  p.description "Ruby is the most exciting dynamic language out there."
  p.image_url "ruby.png"
  p.price 49.50
end
