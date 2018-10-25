
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, message: "Rating must be greater than 0"}
  validates :rating, numericality: { less_than_or_equal_to: 5, message: "We're flattered but this product can only be rated out of 5."}
  # def item_ownership?
  #   return self.product.user_id == session[:user_id]
  # end
end
