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

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"
