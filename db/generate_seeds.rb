require 'faker'
require 'date'
require 'csv'

CSV.open("db/addresses_seeds.csv", "w", :write_headers=> true,
  :headers => ["user_id", "first_name", "last_name", "street", "street_2","city","state","zip"]) do |csv|

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
