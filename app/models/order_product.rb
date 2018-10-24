class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0, message: "Must add atleast a quantity of one."}

  def item_subtotal
    self.product.price_in_cents * self.quantity
  end
end
