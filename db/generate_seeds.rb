require 'faker'
require 'date'
require 'csv'

CSV.open('db/user_seeds.csv', "w", :write_headers=> true,
  :headers => ["id", "first_name", "last_name", "email", "is_a_seller", "uid", "provider"]) do |csv|

  20.times do |i|
    id = i
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email("#{first_name}")
    is_a_seller = true
    uid = rand(11111111..99999999)
    provider = %w(github twitter facebook google).sample

    csv << [id, first_name, last_name, email, is_a_seller, uid, provider]
  end
end

CSV.open('db/address_seeds.csv', "w", :write_headers=> true,
  :headers => ["user_id", "first_name", "last_name", "street", "street_2", "city","state", "zip"]) do |csv|

  20.times do |i|
    id = i
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email("#{first_name}")
    is_a_seller = true
    uid = rand(11111111..99999999)
    provider = %w(github twitter facebook google).sample

    csv << [id, first_name, last_name, email, is_a_seller, uid, provider]
  end
end




CSV.open("db/product_seeds.csv", "w", :write_headers=> true,
  :headers => ["category", "name", "user_id", "price_in_cents", "description", "quantity"]) do |csv|

  20.times do

    category = %w(sheet filled shell long short
    soup gluten-free).sample
    name = Faker::BreakingBad.character
    price_in_cents = rand(100..5000)
    description = Faker::Cannabis.health_benefit
    quantity = rand(1..20)



    csv << [category, name, price_in_cents, description, quantity]

  end

  CSV.open('db/order_seeds.csv', "w", :write_headers=> true,
    :headers => ["user_id", "status", "payment_id", "address_id"]) do |csv|

    20.times do |i|
      user_id = i
      status = "placed"
      payment_id = rand(1000..5000)
      address_id = rand(1..25)

      csv << [user_id, status, payment_id, address_id]
    end

  end

end

# CSV.open("db/order_products_seeds.csv", "w", :write_headers=> true,
#   :headers => ["user_id", "status","payment_id", "address_id"]) do |csv|
#
#   20.times do
#     user_id = rand(1..25)
#     status = %w(pending paid complete cancelled).sample
#     payment_id = rand(1..2000)
#     address_id = rand(1..200)
#
#
#     csv << [user_id, status, payment_id, address_id]
#   end
# end
