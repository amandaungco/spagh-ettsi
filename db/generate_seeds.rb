require 'faker'
require 'date'
require 'csv'

CSV.open('db/user_seeds.csv', "w", :write_headers=> true,
  :headers => ["first_name", "last_name", "email", "is_a_seller", "uid", "provider"]) do |csv|

  20.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email("#{first_name}")
    is_a_seller = true
    uid = rand(11111111..99999999)
    provider = %w(github twitter facebook google).sample

    csv << [first_name, last_name, email, is_a_seller, uid, provider]
  end
end

CSV.open('db/address_seeds.csv', "w", :write_headers=> true,
  :headers => ["user_id", "first_name", "last_name", "street", "street_2", "city","state", "zip"]) do |csv|

  20.times do
    user_id = rand(1..20)
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    street = Faker::Address.street_address
    street_2 = Faker::Address.secondary_address
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = rand(11111..99999)


    csv << [user_id, first_name, last_name, street, street_2, city, state, zip]
  end
end

CSV.open('db/payment_seeds.csv', "w", :write_headers=> true,
  :headers => ["user_id", "address_id", "card_number", "expiration_date", "cvv", "card_type"]) do |csv|

  20.times do

    user_id = rand(1..20)
    address_id = rand(1..20)
    card_number = rand(111111111111111..999999999999999)
    expiration_date = Faker::Date.forward(600)
    cvv = rand(111..9999)
    card_type = %w(AMEX VISA MASTERCARD DISCOVER).sample


    csv << [user_id, address_id, card_number, expiration_date, cvv, card_type]
  end
end


CSV.open("db/product_seeds.csv", "w", :write_headers=> true,
  :headers => ["category", "name", "user_id", "price_in_cents", "description", "quantity"]) do |csv|
  pasta = ["callentani", "cappalini", "ditalini", "elbow", "farfalle",
    "fettuccine", "gemelli", "gluten free shells", "large shells", "lasagna",
    "manicotti", "medium_shells", "orzo", "pappardelle", "pastina",
    "penne", "ravioli", "rotini", "spaghetti", "tortellini"]
  ]
  20.times do |i|

    category = %w(sheet filled shell long short
    soup gluten-free).sample
    name = pasta[i]
    user_id = rand(1..20)
    price_in_cents = rand(100..5000)
    description = Faker::Cannabis.health_benefit
    quantity = rand(1..20)



    csv << [category, name, user_id, price_in_cents, description, quantity]

  end

  CSV.open('db/order_seeds.csv', "w", :write_headers=> true,
    :headers => ["user_id", "status", "payment_id", "address_id"]) do |csv|

    20.times do
      user_id = rand(1..20)
      status = "placed"
      payment_id = rand(1..20)
      address_id = rand(1..20)

      csv << [user_id, status, payment_id, address_id]
    end

  end

  CSV.open('db/order_products_seeds.csv', "w", :write_headers=> true,
    :headers => ["order_id", "product_id", "quantity"]) do |csv|

    20.times do
      order_id = rand(1..20)
      product_id = rand(1..20)
      quantity = rand(1..20)

      csv << [order_id, product_id, quantity]
    end

  end

  CSV.open('db/review_seeds.csv', "w", :write_headers=> true,
    :headers => ["user_id", "product_id", "review", "rating"]) do |csv|

    20.times do

      user_id = rand(1..20)
      product_id = rand(1..20)
      review = Faker::Cannabis.health_benefit
      rating = rand(1..5)

      csv << [user_id, product_id, review, rating]
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
