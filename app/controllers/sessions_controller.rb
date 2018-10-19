class SessionsController < ApplicationController
  def create
     auth_hash = request.env['omniauth.auth']
     user = User.find_by(uid: auth_hash[:uid], provider:'github')
     raise
   end
 end

  def destroy
  end
end
