class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy, :shopping_cart]
  def index
  end

  def show
  end

  def new
  end

  def create(order_params)
    @order = Order.new(order_params)
    if !@order.save
      flash[:warning] = "There was an error.  Could not create shopping cart."
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:success] = "Your order has been placed!"
      session[:shopping_cart_id] = nil
      redirect_to root_path #redirect to order # show page?
    else
      flash[:warning] = "Unable to place order"
      flash[:validation_errors] = @order.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def shopping_cart

  end

private

  def find_order
    @order = Order.find_by(id: session[:shopping_cart_id])
  end

  def order_params
    params.require(:order).permit(:payment_id, :address_id, :status)

  end

end
