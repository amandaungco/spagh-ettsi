class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def address_params
      params.require(:address).permit(:user_id, :first_name, :last_name,
      :street, :street_2, :city, :state, :zip)
    end

    def find_addresses
      @address = Address.find_by(id: params[:id].to_i)

      if @address.nil?
        render :notfound, status: :not_found
      end
    end

end
