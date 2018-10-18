class UsersController < ApplicationController

  def create(guest_params)
    return guest_user = User.new(guest_params)
  end

end
