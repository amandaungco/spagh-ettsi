class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :payment, optional: true
  belongs_to :address, optional: true
  belongs_to :user

  validates :user_id, presence: true
  #validates :address_id, presence: true,
  validates :payment_id, presence: true, if: :order_placed?#, message: 'Must enter a payment to submit order'
  validates :status, presence: true

  def order_placed?
    self.status == "placed"
  end

end
