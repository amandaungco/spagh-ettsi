class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_one :address
end
