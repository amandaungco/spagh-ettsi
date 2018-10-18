class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  has_one :payment
  has_one :address
  belongs_to :user

  validates :user_id, presence: true
  validates :address_id, presence: true
  validates :payment_id, presence: true
  validates :status, presence: true
end
