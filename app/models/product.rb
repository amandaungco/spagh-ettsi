class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user
  has_many :order_products
  has_many :orders, through: :order_products
end
