require 'faker'
require 'date'
require 'csv'

CSV.open("db/payments_seeds.csv", "w", :write_headers=> true,
  :headers => ["user_id", "address_id", "card_number", "expiration_date", "cvv", "card_type"]) do |csv|

  20.times do
    user_id = rand(1..25)
    address_id = rand(1..200)
    card_number = rand.to_s[2..10]
    expiration_date = %w(02/20 03/21 04/22 08/23 10/24 12/25).sample
    cvv = rand(111..999)
    card_type = %w(mastercard visa discover amex).sample


    csv << [user_id, address_id, card_number, expiration_date, cvv, card_type]
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
# CSV.open('db/media_seeds.csv', "w", :write_headers=> true,
#   :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|
#
#   75.times do
#     category = %w(album book movie).sample
#     title = Faker::Book.title
#     creator = Faker::RuPaul.queen
#     publication_year = rand(Date.today.year-100..Date.today.year)
#     description = Faker::Simpsons.quote
#
#     csv << [category, title, creator, publication_year, description]
#   end
# end
