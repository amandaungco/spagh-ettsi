# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new(
    id: row['id'],
    first_name: row['first_name'],
    last_name: row['last_name'],
    email: row['email'],
    is_a_seller: row['is_a_seller'],
    uid: row['uid'],
    provider: row['provider']
  )

  successful = user.save

  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
    puts "#{user.errors.full_messages}"
  else
    puts "Created user: #{user.inspect}"
  end
end


ADDRESSES_FILE = Rails.root.join('db', 'addresses_seeds.csv')
puts "Loading raw user data from #{ADDRESSES_FILE}"

address_failures = []
CSV.foreach(ADDRESSES_FILE, :headers => true) do |row|
  address = Address.new(
    user_id: row['user_id'],
    id: row['id'],
    first_name: row['first_name'],
    street: row['street'],
    street_2: row['street_2'],
    city: row['city'],
    state: row['state'],
    zip: row['zip'],
  )

  successful = address.save

  if !successful
    address_failures << address
    puts "Failed to save address: #{address.inspect}"
    puts "#{address.errors.full_messages}"
  else
    puts "Created address: #{address.inspect}"
  end
end


PAYMENTS_FILE = Rails.root.join('db', 'payments_seeds.csv')
puts "Loading raw user data from #{PAYMENTS_FILE}"

payment_failures = []
CSV.foreach(PAYMENTS_FILE, :headers => true) do |row|
  payment = Payment.new(
    user_id: row['user_id'],
    address_id: row['card_number'],
    card_number: row['last_name'],
    expiration_date: row['expiration_date'],
    cvv: row['cvv'],
    card_type: row['card_type']
  )

  successful = payment.save

  if !successful
    payment_failures << payment
    puts "Failed to save payment: #{payment.inspect}"
    puts "#{payment.errors.full_messages}"
  else
    puts "Created payment: #{payment.inspect}"
  end
end




PRODUCT_FILE = Rails.root.join('db', 'product_seeds.csv')
puts "Loading raw product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new(

    category: row['category'],
    name: row['name'],
    user_id: row['user_id'],
    price_in_cents: row['price_in_cents'],
    description: row['description'],
    quantity: row['quantity']
  )

  successful = product.save

  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
    puts "#{product.errors.full_messages}"
  else
    puts "Created product: #{product.inspect}"
  end
end

ORDER_FILE = Rails.root.join('db', 'order_seeds.csv')
puts "Loading raw user data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new(
    user_id: row['user_id'],
    status: row['status'],
    payment_id: row['payment_id'],
    address_id: row['address_id'],
  )

  successful = order.save


  if !successful
    order_failures << user
    puts "Failed to save order: #{order.inspect}"
    puts "#{order.errors.full_messages}"
  else
    puts "Created order: #{order.inspect}"
  end
end

ORDER_PRODUCTS_FILE = Rails.root.join('db', 'order_products.csv')
puts "Loading raw user data from #{ORDER_PRODUCTS_FILE}"

order_products_failures = []
CSV.foreach(ORDER_PRODUCTS_FILE, :headers => true) do |row|
  order_products = Order_products.new(
    order_id: row['order_id'],
    product_id: row['product_id'],
    quantity: row['quantity']
  )

  successful = order_products.save

  if !successful
    order_products_failures << order_products
    puts "Failed to save order_products: #{order_product.inspect}"
    puts "#{order_product.errors.full_messages}"
  else
    puts "Created order_products: #{order_product.inspect}"
  end
end

REVIEWS_FILE = Rails.root.join('db', 'reviews.csv')
puts "Loading raw user data from #{REVIEWS_FILE}"

reviews_failures = []
CSV.foreach(REVIEWS_FILE, :headers => true) do |row|
  review = Review.new(
    user_id: row['user_id'],
    product_id: row['product_id'],
    review: row['review'],
    rating: row['rating']
  )

  successful = review.save

  if !successful
    review_failures << review

    puts "Failed to save review: #{review.inspect}"
    puts "#{review.errors.full_messages}"
  else
    puts "Created reviews: #{review.inspect}"
  end


  puts "Added #{User.count} user records"
  puts "#{user_failures.length} users failed to save."

  puts "Added #{Product.count} product records"
  puts "#{product_failures.length} products failed to save."

  puts "Added #{Order_product.count} order_product records"
  puts "#{order_product_failures.length} order_products failed to save."

  puts "Added #{Order.count} order records"
  puts "#{order_failures.length} orders failed to save."

  puts "Added #{Address.count} address records"
  puts "#{address_failures.length} address failed to save."

  puts "Added #{Payment.count} payment records"
  puts "#{payment_failures.length} payments failed to save."

  puts "Added #{Review.count} review records"
  puts "#{review_failures.length} reviews failed to save."

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save."

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)

end
