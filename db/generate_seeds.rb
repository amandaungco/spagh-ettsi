require 'faker'
require 'date'
require 'csv'

CSV.open("db/addresses_seeds.csv", "w", :write_headers=> true,
  :headers => ["user_id", "first_name", "last_name", "street", "street_2","city","state","zip"]) do |csv|

  20.times do
    user_id = rand(1..20)
    product_id = rand(1..200)
    review = Faker::Cannabis.health_benefit
    rating = rand(1..5)


    csv << [user_id, product_id, review, rating]
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
