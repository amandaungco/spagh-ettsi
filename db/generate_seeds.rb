require 'faker'
require 'date'
require 'csv'

CSV.open("db/product_seeds.csv", "w", :write_headers=> true,
  :headers => ["category", "name", "user_id", "price_in_cents", "description", "quantity"]) do |csv|

  20.times do
    category = %w(long short shell sheet filled soup).sample
    name = Faker::Superhero.name
    user_id = rand(1..20)
    price_in_cents = rand(1000..5000)
    description = Faker::Simpsons.quote
    quantity = rand(1..100)

    csv << [category, name, user_id, price_in_cents, description, quantity]
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
