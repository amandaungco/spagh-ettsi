class ApplicationController < ActionController::Base

  before_action :find_login_user, :find_shopping_cart

  def find_login_user
    @login_user = User.find_by(id: session[:user_id])
  end

  def find_shopping_cart
    if @login_user
      @shopping_cart = Order.find_by(user_id: @login_user.id, status: :pending)
    end
  end

end
