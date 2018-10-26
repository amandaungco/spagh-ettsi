class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user
  has_many :order_products
  has_many :orders, through: :order_products

  #validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price_in_cents, presence: true, numericality: { greater_than: 0, message: "Price must be greater than 0"}
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, message: "Stock cannot go below 0"}
  validates :category, presence: true
  validates :description, presence: true
  # validates_format_of :image_url,:with => /\A[http]/

  def self.categories
    return ['long', 'short', 'shell', 'sheet', 'filled', 'soup']
  end

  def self.active_products
    return Product.where(is_active: true)
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

  # def self.merchant_owners
  #   return
  # end

end
