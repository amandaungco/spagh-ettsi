class User < ApplicationRecord
  has_many :orders
  has_many :products
  has_many :addresses
  has_many :payments
  has_many :reviews


end
