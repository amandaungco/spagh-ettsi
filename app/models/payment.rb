class Payment < ApplicationRecord
  belongs_to :user
  has_many :orders
  belongs_to :address
end
