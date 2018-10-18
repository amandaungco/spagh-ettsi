class Address < ApplicationRecord
  belongs_to :user
  has_one :payment

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true , numericality: true

end
