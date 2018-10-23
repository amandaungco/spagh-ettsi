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
    all_orders = all_orders_for_merchant
    all_merchant_order_products = []
    specific_merchant_ops = []
    total_revenue = 0
    all_orders.each do |order|
      all_merchant_order_products << order.order_products
    end
    all_merchant_order_products.flatten!
    all_merchant_order_products.each do |order_product|
      if order_product.product.user_id == self.id
      #binding.pry
        specific_merchant_ops << order_product
      end
    end

    specific_merchant_ops.each do |op|
      item_total = op.item_subtotal

      total_revenue += item_total
    end
    return total_revenue

  end

  def total_revenue_by_paid
    all_orders = paid_orders_for_merchant
    all_merchant_order_products = []
    specific_merchant_ops = []
    total_revenue = 0
    all_orders.each do |order|
      all_merchant_order_products << order.order_products
    end
    all_merchant_order_products.flatten!
    all_merchant_order_products.each do |order_product|
      if order_product.product.user_id == self.id
      #binding.pry
        specific_merchant_ops << order_product
      end
    end

    specific_merchant_ops.each do |op|
      item_total = op.item_subtotal

      total_revenue += item_total
    end
    return total_revenue

  end

  def total_revenue_by_completed
    all_orders = completed_orders_for_merchant
    all_merchant_order_products = []
    specific_merchant_ops = []
    total_revenue = 0
    all_orders.each do |order|
      all_merchant_order_products << order.order_products
    end
    all_merchant_order_products.flatten!
    all_merchant_order_products.each do |order_product|
      if order_product.product.user_id == self.id
      #binding.pry
        specific_merchant_ops << order_product
      end
    end

    specific_merchant_ops.each do |op|
      item_total = op.item_subtotal

      total_revenue += item_total
    end
    return total_revenue

  end

  def all_orders_for_merchant
    orders = Order.joins(:products).where({products: {user: self}}).where().not(status: :pending)
    return orders.uniq
  end

  def paid_orders_for_merchant
    all_orders_for_merchant.select{|o| o.status == 'paid'}
  end

  def completed_orders_for_merchant
    all_orders_for_merchant.select{|o| o.status == 'complete'}
  end

  def active_products
    self.products.where(is_active: true)
  end

  def inactive_products
    self.products.where(is_active: false)
  end




end
