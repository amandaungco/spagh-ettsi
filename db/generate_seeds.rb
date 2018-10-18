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

CSV.open("db/product_seeds.csv", "w", :write_headers=> true,
  :headers => ["category", "name", "user_id", "price_in_cents", "description", "quantity"]) do |csv|

  20.times do

    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    street = Faker::Address.street_address
    street_2 = Faker::Address.secondary_address
    city = Faker::Address.city
    state = Faker::Address.state
    zip = Faker::Address.zip


    csv << [first_name, last_name, street, street_2, city, state, zip]

  end
end
