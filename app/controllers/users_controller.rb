class UsersController < ApplicationController

  def create(guest_params)
    return guest_user = User.new(guest_params)
  end

  def show
    if @login_user
      @login_user_orders = Order.where(user_id: @login_user.id).where().not(status: :pending)
    end
    render :account
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
    end
    @total_orders = @login_user.all_orders_for_merchant.count
    @orders = @login_user.all_orders_for_merchant

    @total_paid_orders = @login_user.paid_orders_for_merchant.count
    @paid_orders = @login_user.paid_orders_for_merchant

    @total_completed_orders = @login_user.completed_orders_for_merchant.count
    @completed_orders = @login_user.completed_orders_for_merchant

    @total_active_products = @login_user.active_products.count
    @active_products = @login_user.active_products

    @total_inactive_products = @login_user.inactive_products.count
    @inactive_products = @login_user.inactive_products

    @total_products = @login_user.products.count
  end

  def orders_index
    @total_orders = @login_user.all_orders_for_merchant.count
    @orders = @login_user.all_orders_for_merchant

    @total_paid_orders = @login_user.paid_orders_for_merchant.count
    @paid_orders = @login_user.paid_orders_for_merchant

    @total_completed_orders = @login_user.completed_orders_for_merchant.count
    @completed_orders = @login_user.completed_orders_for_merchant
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
    @active_products = @login_user.active_products
    @inactive_products = @login_user.inactive_products
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



end
