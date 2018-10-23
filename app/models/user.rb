class User < ApplicationRecord
  has_many :orders
  has_many :products
  has_many :addresses
  has_many :payments
  has_many :reviews

  validates :is_a_seller, inclusion: {in: [false], message: "Must be a registered user to become a seller"}, if: :guest?
  validates :full_name, presence: true
  validates :email, presence: true
  validates_format_of :email,:with => /.+@.+\..+/
  validates :uid, presence: true
  validates :provider, presence: true

  def self.build_from_github(auth_hash)
   user = User.new
   user.uid = auth_hash[:uid]
   user.provider = 'github'
   user.full_name = auth_hash['info']['name']
   user.email = auth_hash['info']['email']
   return user
  end

  def guest?
    return self.provider == 'guest_login'
  end

  def total_revenue

  end

  def paid_orders_by_seller
  end

  def completed_orders_by_seller
  end

  def products_by_seller
  end




end
