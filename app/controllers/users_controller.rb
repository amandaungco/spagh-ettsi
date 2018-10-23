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
