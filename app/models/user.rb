class User < ApplicationRecord
  has_many :orders
  has_many :products
  has_many :addresses
  has_many :payments
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_format_of :email,:with => /.+@.+\..+/
  validates :uid, presence: true
  validates :provider, presence: true

  def self.build_from_github(auth_hash)
   user = User.new
   user.uid = auth_hash[:uid]
   user.provider = 'github'
   user.name = auth_hash['info']['name']
   user.email = auth_hash['info']['email']
   return user
  end


end
