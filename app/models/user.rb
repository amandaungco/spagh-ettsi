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
        specific_merchant_ops << order_product
      end
    end

    specific_merchant_ops.each do |op|
      item_total = op.item_subtotal

      total_revenue += item_total
    end
    return total_revenue
  end

  def total_revenue_by_status(status)
    orders_by_status = sort_orders_by_status(status)
    all_merchant_order_products = []
    specific_merchant_ops = []
    total_revenue = 0
    orders_by_status.each do |order|
      all_merchant_order_products << order.order_products
    end
    all_merchant_order_products.flatten!
    all_merchant_order_products.each do |order_product|
      if order_product.product.user_id == self.id
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

  def sort_orders_by_status(status)
      return all_orders_for_merchant.select{|o| o.status == status}
  end

  def product_status(boolean)
    self.products.where(is_active: boolean)
  end

  def self.merchants
    User.where(is_a_seller: true)
  end

end
