# Users
User.create!(
  name: "Nguyen Ngoc Man",
  email: "yinyang1011@gmail.com",
  address: "Đông hà, Quảng Trị",
  phone: "0123456789",
  role: 1,
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.zone.now)

5.times do |n|
  User.create!(
    name: Faker::FunnyName.name,
    email: "yin#{n+1}@gmail.com",
    address: Faker::Address.full_address,
    phone: Faker::Number.leading_zero_number(digits: 10),
    role: 0,
    password:"123123",
    password_confirmation: "123123",
    confirmed_at: Time.zone.now)
end

# User.create!(name: "Nguyen Ngoc Man",
#   email: "yinyang1011@gmail.com",
#   address: "Đông hà, Quảng Trị",
#   phone: "0123456789",
#   role: 1,
#   password: "123456",
#   password_confirmation: "123456",
#   activated_at: Time.zone.now)

# 30.times do |n|
#   User.create!(
#     name: Faker::FunnyName.name,
#     email: "example#{n+1}@gmail.com",
#     password:"123123",
#     password_confirmation: "123123",
#     address: Faker::Address.full_address,
#     phone: Faker::Number.leading_zero_number(digits: 10),
#     role: 0,
#     activated_at: Time.zone.now)
# end

# Categories
Category.create!(name: "Foods")
Category.create!(name: "Drinks")

# Products
categories = Category.all
categories.each do |category|
  10.times do |n|
    Product.create!(
      category_id: category.id,
      name: category.name + " #{n+1}",
      information: Faker::Food.description,
      price: Faker::Number.decimal(l_digits: 2),
      quantity: Faker::Number.non_zero_digit,
      rating_score: 4.4
      )
  end
end

# Images
c1 = Category.find_by name: "Foods"
c2 = Category.find_by name: "Drinks"
food_products = c1.products
drink_products = c2.products

food_products.each do |product|
  product.images.create!(
    image_url: "food.jpg"
    )
end

drink_products.each do |product|
  product.images.create!(
    image_url: "drink.jpg"
    )
end

User.first.images.create!(
  image_url: "user.png"
)
# Orders
6.times do |n|
  Order.create!(
    user_id: User.admin.pluck(:id).sample,
    status: Order.statuses.values.sample,
    total: 0
    )
end

6.times do |n|
  Order.create!(
    user_id: User.limit(3).pluck(:id).sample,
    status: Order.statuses.values.sample,
    total: 0
    )
end

# Orders Details
20.times do |n|
  OrderDetail.create!(
    order_id: Order.pluck(:id).sample,
    product_id: Product.pluck(:id).sample,
    current_price: Faker::Number.decimal(l_digits: 2),
    quantity: rand(1..10)
    )
end

# Rates
25.times do |n|
  Rate.create!(
    user_id: User.limit(3).pluck(:id).sample,
    product_id: Product.pluck(:id).sample,
    rating: rand(1..5)
    )
end

# Suggests
10.times do |n|
  Suggest.create!(
    user_id: User.limit(3).pluck(:id).sample,
    name: Faker::Lorem.word,
    information: Faker::Lorem.paragraph,
    status: Suggest.statuses.values.sample
    )
end
