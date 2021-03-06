class AddressesController < ApplicationController
  #
  # def index
  #   @addresses = Address.all
  # end
  #
  # def show
  # end

  def new
    if @login_user
      @address = Address.new()
    else
      render 'layouts/not_found', status: :bad_request
    end
  end

  def create
    @address = Address.new(address_params)

    if @address.user != @login_user
      flash[:warning] = "You must be logged in to add an address"
      render 'layouts/not_found', status: :bad_request
    else
      if @address.save
        flash[:success] = "Successfully created address."
        redirect_to checkout_path
      else
        flash.now[:warning] = "A problem occurred: Could not create address."
        flash.now[:validation_errors] = @address.errors.full_messages

        render :new, status: :bad_request
      end
    end
  end

  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

  private
    def address_params
      params.require(:address).permit(:user_id, :first_name, :last_name,
      :street, :street_2, :city, :state, :zip)
    end

    # def find_address
    #   @address = Address.find_by(id: params[:id].to_i)
    #
    #   if @address.nil?
    #     render 'layouts/not_found', status: :not_found
    #   end
    # end

end
