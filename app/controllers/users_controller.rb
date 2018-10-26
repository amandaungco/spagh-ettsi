class UsersController < ApplicationController
  before_action :find_orders_info, only: [:dashboard, :orders_index]
  before_action :find_products, only: [:dashboard, :products_index]

  def create(guest_params)
    return guest_user = User.new(guest_params)
  end

  def show
    if @login_user.nil? || @login_user.provider == 'guest_login'
      redirect_to root_path
      flash[:warning] = "Oops, you must create an account to view this page!"
    else
      @login_user_orders = Order.where(user_id: @login_user.id).where().not(status: :pending)
      render :account
    end
  end

  def update
    @login_user.is_a_seller = params[:user][:is_a_seller]
    if @login_user.save

      if @login_user.products.any?
        if @login_user.is_a_seller
          activate_user_products
        else
          deactivate_user_products
        end
      end

      flash[:success] = "Account settings updated!"
      redirect_to account_path
    else
      flash[:warning] = "Oops, there was a problem updating your account."
      flash[:validation_errors] = @login_user.errors.full_messages
    end

  end

  def dashboard
    if @login_user.nil? || !@login_user.is_a_seller?
      redirect_to root_path
      flash[:warning] = "You don't have permission to view that page"
    else
      # @total_orders = @login_user.all_orders_for_merchant.count
      # @orders = @login_user.all_orders_for_merchant

      # @total_paid_orders = @login_user.sort_orders_by_status('paid').count
      # @paid_orders = @login_user.sort_orders_by_status('paid')

      # @total_completed_orders = @login_user.sort_orders_by_status('complete').count
      # @completed_orders = @login_user.sort_orders_by_status('complete')

      @total_active_products = @active_products.count
      #@active_products = @login_user.product_status(true)

      @total_inactive_products = @inactive_products.count
      # @inactive_products = @login_user.product_status(false)

      @total_products = @login_user.products.count
    end
  end

  def orders_index
    # @total_orders = @login_user.all_orders_for_merchant.count
    # @orders = @login_user.all_orders_for_merchant
    #
    # @total_paid_orders = @login_user.sort_orders_by_status('paid').count
    # @paid_orders = @login_user.sort_orders_by_status('paid')
    #
    # @total_completed_orders = @login_user.sort_orders_by_status('complete').count
    # # @completed_orders = @login_user.sort_orders_by_status('complete')
  end

  def order_show
    @order = Order.find_by(id: params[:id])
    if !@order || @order.status == :pending
      render 'layouts/not_found', status: :not_found
    end
    @order_products = @order.order_products_by_merchant(@login_user)
    @order_subtotal = @order.order_subtotal_by_merchant(@login_user)
  end

  def products_index
    @products = @login_user.products
    # @active_products = @login_user.product_status(true)
    # @inactive_products = @login_user.product_status(false)
  end





  def deactivate_user_products
    @login_user.products.each do |product|
      product.is_active = false
      product.save
    end
  end

  def activate_user_products
    @login_user.products.each do |product|
      product.is_active = true
      product.save
    end
  end
  private

  def find_orders_info
    @orders = @login_user.all_orders_for_merchant
    @total_orders = @orders.count
    @paid_orders = @login_user.sort_orders_by_status('paid')
    @total_paid_orders = @paid_orders.count
    @completed_orders = @login_user.sort_orders_by_status('complete')
    @total_completed_orders = @completed_orders.count
  end

  def find_products
    @active_products = @login_user.product_status(true)
    @inactive_products = @login_user.product_status(false)
  end



end
