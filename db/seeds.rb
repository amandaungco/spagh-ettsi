# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

MEDIA_FILE = Rails.root.join('db', 'product_seeds.csv')
puts "Loading raw product data from #{MEDIA_FILE}"

product_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  product = Product.new

  product.category = row['category']
  product.name = row['name']
  product.user_id = row['user_id']
  product.price_in_cents = row['price_in_cents']
  product.description = row['description']
  product.quantity = row['quantity']

  successful = product.save

  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"

  else
    puts "Created product: #{product.inspect}"
  end
end


puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save."


puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save."
