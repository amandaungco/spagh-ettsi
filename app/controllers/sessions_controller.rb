require 'pry'
class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: 'github')

    if user

      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.full_name}"

    else
      user = User.build_from_github(auth_hash)

      if user.save

        flash[:success] = "Logged in as new user #{user.full_name}"
      else
        flash[:warning] = "Could not create new user account: #{user.errors.messages}"
        flash[:validation_errors] = user.errors.messages

        redirect_to root_path
        return
      end
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out. Pasta la Vista, baby!"

    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
