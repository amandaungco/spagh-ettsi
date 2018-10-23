class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :users, through: :products

  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, presence: true, numericality: true

  def item_subtotal
    self.product.price_in_cents * self.quantity
  end
end
