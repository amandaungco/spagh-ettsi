class OrderProductsController < ApplicationController

  def create

    check_login

    check_shopping_cart

    product = Product.find_by(id: params[:order_product][:product_id])
    quantity = params[:order_product][:quantity].to_i

    existing_row = OrderProduct.find_by(product_id: product.id, order_id: session[:shopping_cart_id])

    if existing_row
      existing_row.quantity += quantity
      existing_row.save
      flash[:success] = "Cart has been updated!"

      redirect_to shopping_cart_path

    else OrderProduct.create(product_id: product.id, order_id: session[:shopping_cart_id], quantity: quantity)
      product.quantity -= quantity
      product.save
      flash[:success] = "Cart has been updated!"

      redirect_to shopping_cart_path
    end

  end

  def update
    order_product = OrderProduct.find_by(id: params[:order_product][:id])
    old_quantity = order_product.quantity

    order_product.update(quantity: params[:order_product][:quantity])
    new_quantity = order_product.quantity

    change_inventory = new_quantity - old_quantity

    order_product.product.quantity -= change_inventory

    order_product.product.save

    if order_product.quantity == 0
      order_product.destroy
      flash[:success] = "#{order_product.product.name} removed from cart."
    else
      flash[:success] = "#{order_product.product.name} quantity updated."
    end

    redirect_to shopping_cart_path
  end

  def check_login
    if !session[:user_id]
      flash[:warning] = "You are not logged in, continuing as guest."
      user = User.create(
        full_name: 'Guest user',
        email: 'example@example.com',
        is_a_seller: false,
        uid: rand(11111111..99999999),
        provider: 'guest_login'
      )

      session[:user_id] = user.id
    end
  end

  def check_shopping_cart
    shopping_cart = Order.find_by(user_id: session[:user_id], status: :shopping_cart)

    if !shopping_cart
      shopping_cart = Order.create(
        user_id: session[:user_id],
        status: :shopping_cart,
        payment_id: nil,
        address_id: nil
      )

    end

    session[:shopping_cart_id] = shopping_cart.id
  end



end
