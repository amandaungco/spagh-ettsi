class OrdersController < ApplicationController
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
  end

  def destroy
  end

  def shopping_cart
    @order = Order.find_by(id: session[:shopping_cart_id])
  end

end
