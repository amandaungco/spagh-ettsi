class UsersController < ApplicationController

  def create(guest_params)
    return guest_user = User.new(guest_params)
  end

  def show
    if @login_user
      @login_user_orders = Order.where(user_id: @login_user.id, status: :placed)
    end
    render :account
  end

end
