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

  def self.categories
    return ['long', 'short', 'shell', 'sheet', 'filled', 'soup']
  end

  def self.active_products
    return Product.where(is_active: true)
  end

  def self.merchant_owners
    return
  end

end
