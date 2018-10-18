class Payment < ApplicationRecord
  belongs_to :user
  has_many :orders
  belongs_to :address

  validates :user_id, presence: true
  validates :address_id, presence: true
  validates :card_number, presence: true, numericality: true #length: { is: 16 }
  validates :expiration_date, presence: true
  validates :cvv, presence: true, numericality: true
  validates :card_type, presence: true
end
