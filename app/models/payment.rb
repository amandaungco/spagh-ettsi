class Payment < ApplicationRecord
  belongs_to :user
  has_many :orders
  belongs_to :address

  validates :user_id, presence: true
  validates :address_id, presence: true
  validates :card_number, presence: true, numericality: true, length: { in: 14..17 }
  validates :expiration_date, presence: true
  validates :cvv, presence: true, numericality: true, length: { in: 3..6 }
  validates :card_type, presence: true

  def self.card_types
    return ['AMEX', 'Visa', 'MasterCard', 'Discover', 'Spagh-Ettsi Gift Card']
  end

  def last_four_digits
    self.card_number.to_s.last(4)
  end
end
