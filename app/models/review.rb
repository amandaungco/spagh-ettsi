require 'pry'
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :rating, presence: true, numericality: true
end

def average_rating
  ratings = 0
  self.reviews.each do |review|
    ratings += review.rating if review.rating
  end
  if ratings == 0
    return "Not yet rated"
  else
    return (ratings.to_i / self.reviews.length).round(2)
  end
end
