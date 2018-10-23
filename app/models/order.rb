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
    return self.status == "paid"
  end

  def order_subtotal
    return self.order_products.sum{|row| row.item_subtotal}
  end

  def seattle_sales_tax
    return (0.101 * self.order_subtotal).round(0)
  end

  def flat_rate_shipping
    return 1000
  end

  def order_total
    return self.order_subtotal + self.flat_rate_shipping + self.seattle_sales_tax
  end
end
