class Address < ApplicationRecord
  belongs_to :user
  has_one :payment
  has_many :orders


end
