class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :address
end
