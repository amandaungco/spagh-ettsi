
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :rating, presence: true, numericality: true
  #use scope check media ranker for validation that a user cannot review their ownr product

  # def item_ownership?
  #   return self.product.user_id == session[:user_id]
  # end
end
