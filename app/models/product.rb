class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user
  has_many :order_products
  has_many :orders, through: :order_products

  validates :user_id, presence: true
  validates :name, presence: true
  validates :price_in_cents, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :category, presence: true
  validates :description, presence: true

  def self.images(id)
    # create regex to accurately get posts from data with single digit id
    images = Dir.glob("public/images/*.jpg")
    image_url = images.select { |x| x.include? id.to_s }.first
    correct_path = image_url.gsub("public", "")
    return correct_path
  end
end
