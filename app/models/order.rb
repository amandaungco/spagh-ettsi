class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  has_one :payment
  has_one :address
  has_one :user
end
