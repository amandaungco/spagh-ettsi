class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :payment, optional: true
  belongs_to :address, optional: true
  belongs_to :user

  validates :user_id, presence: true
  validates :address_id, presence: true, if: :order_placed?
  validates :payment_id, presence: true, if: :order_placed?
  validates :status, presence: true

  def order_placed?
    self.status == "placed"
  end

  def order_subtotal
    self.order_products.sum{|row| row.item_subtotal}
  end

end
