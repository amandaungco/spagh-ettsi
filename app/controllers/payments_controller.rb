class PaymentsController < ApplicationController
  def index
  end

  def show
  end

  def new
      @payment = Payment.new()
      @card_types = Payment.card_types
  end

  def create
    @payment = Payment.new(payment_params)


    if @payment.save
      flash[:success] = "Successfully created payment."
      redirect_to checkout_path
    else
      flash.now[:warning] = "A problem occurred: Could not create payment."
      flash.now[:validation_errors] = @payment.errors.full_messages
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :address_id, :card_number, :expiration_date, :cvv, :card_type)

  end
end
