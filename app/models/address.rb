class Address < ApplicationRecord
  belongs_to :user
  has_one :payment


end
