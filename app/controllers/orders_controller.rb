class OrdersController < ApplicationController
before_action :find_order, only: [:show, :edit, :mark_as_shipped, :dashboard]
before_action :check_login_user, except: [:shopping_cart]  # repeated in ApplicationController??
  # def index
  # end

  def show

    if !@order || @order.status == 'pending' || @order.user != @login_user
      render 'layouts/not_found', status: :not_found
    end

    if @login_user.provider == 'guest_login'
      session[:user_id] = nil
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

    if !@shopping_cart || @shopping_cart.user != @login_user
      render 'layouts/not_found', status: :not_found

    # elsif @order.user !=@login_user
    #   render 'layouts/not_found', status: :not_found
    else
      render :checkout
    end
  end

  def mark_as_shipped
    if @order.status != 'complete'
      @order.status = 'complete'
      if @order.save
        redirect_back(fallback_location: merchant_orders_path)
      end
    end
  end

  def update

      if @shopping_cart.products == []

        redirect_to products_path
        flash[:warning] = "Error: Cannot checkout, cart is empty."

      elsif !@login_user.update(user_params)
        flash[:warning] = "An error occurred.  Please try again."
        flash[:validation_errors] = @login_user.errors.full_messages
        redirect_back(fallback_location: checkout_path)

      else
        if @shopping_cart.update(order_params)
          flash[:success] = "Your order has been placed!"
          order_id = session[:shopping_cart_id]
          session[:shopping_cart_id] = nil

          redirect_to order_path(@shopping_cart.id)

        else
          flash[:warning] = "Unable to place order"
          flash[:validation_errors] = @shopping_cart.errors.full_messages
          redirect_back(fallback_location: checkout_path)
        end
      end

  end

  # def dashboard
  # end

  def shopping_cart; end

private

  def find_order
    @order = Order.find_by(id: params[:id].to_i)
  end

  def order_params
    params.permit(:payment_id, :address_id, :status)
  end

  def user_params
    params.permit(:full_name, :email)
  end

  def check_login_user
    if !@login_user
      flash[:warning] = "You must be logged in to see an order."
      redirect_to root_path
    end
  end

end
