class OrderProductsController < ApplicationController

  def create
    params.require(:order_product).permit(:title, :category, :creator, :description, :publication_year)

    if !session[:user_id]
      flash[:warning] = "You are not logged in, continuing as guest."
      user = User.create(
        first_name: 'guest',
        last_name: 'user',
        email: 'example@example.com',
        is_a_seller: false,
        uid: rand(11111111..99999999),
        provider: 'guest_login'
      )

      session[:user_id] = user.id
    end

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

    if OrderProduct.create(product_id: params[:order_product][:product_id], order_id: shopping_cart.id, quantity: params[:order_product][:quantity])
      flash[:success] = "Cart has been updated!"

    redirect_to product_path(params[:order_product][:product_id])
  end



end