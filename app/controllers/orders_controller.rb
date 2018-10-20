class OrdersController < ApplicationController

  def index
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
  end

  def create(order_params)
    @shopping_cart = Order.new(order_params)
    if !@shopping_cart.save
      flash[:warning] = "There was an error.  Could not create shopping cart."
    end
  end

  def edit
    @order = Order.find_by
    render :checkout
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

  def destroy
  end

  def shopping_cart

  end

private


  def order_params
    params.require(:order).permit(:payment_id, :address_id, :status)

  end

end
