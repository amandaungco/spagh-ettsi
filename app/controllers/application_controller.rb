class ApplicationController < ActionController::Base
  ORDER_STATUS = [:shopping_cart, :placed]

  before_action :find_login_user

  def find_login_user
    @login_user = User.find_by(id: session[:user_id])
  end
end
