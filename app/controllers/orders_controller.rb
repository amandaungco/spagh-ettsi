class OrdersController < ApplicationController
before_action :find_order, only: [:show, :edit, :mark_as_shipped]
  # def index
  # end

  def show
    if !@order || @order.status == :pending || @order.user != @login_user
      render 'layouts/not_found', status: :not_found
    end
  end

  # def new; end

  # def create
  #   # @shopping_cart = Order.new
  #   # if !@shopping_cart.save
  #   #   flash[:warning] = "There was an error.  Could not create shopping cart."
  #   # end
  # end

  def edit
    if !@order
      render 'layouts/not_found', status: :not_found
    else
      render :checkout
    end
  end

  def mark_as_shipped
    if @order.status != 'complete'
      @order.status = 'complete'
      if @order.save
        flash[:success] = "Order Shipped!"
        redirect_back(fallback_location: merchant_orders_path)
      end
    end
  end

  def update
    if @shopping_cart.update(order_params)
      flash[:success] = "Your order has been placed!"
      order_id = session[:shopping_cart_id]
      session[:shopping_cart_id] = nil
      redirect_to order_path(order_id)
    else
      flash[:warning] = "Unable to place order"
      flash[:validation_errors] = @shopping_cart.errors.full_messages
      render :checkout
    end
  end

  # def destroy
  # end

  def shopping_cart; end

private

  def find_order
    @order = Order.find_by(id: params[:id].to_i)
  end

  def order_params
    params.require(:order).permit(:payment_id, :address_id, :status)
  end

end
