require "test_helper"

describe PaymentsController do
  let(:buyer) {users(:buyer)}
  let(:home) {addresses(:home)}
  let(:mock_payment_params) {
    {
      payment: {
      user_id: buyer.id,
      address_id: home.id,
      card_number: 123456789012334,
      expiration_date: Date.today,
      cvv: 123,
      card_type: 'AMEX'
      }
    }
  }

  describe 'new' do
    it "succeeds when a user is logged in" do
      @login_user = buyer
      get new_payment_path
      must_respond_with :success
    end

    it "succeeds if a user is not logged in" do
      @login_user = nil
      get new_payment_path
      must_respond_with :success
    end
  end

  describe 'create' do
    it "creates a payment with valid data" do
      expect {
              post payments_path, params: mock_payment_params
            }.must_change 'Payment.count', 1

      payment = Payment.find_by(card_number: mock_payment_params[:payment][:card_number])

      expect(payment.user.id).must_equal mock_payment_params[:payment][:user_id]
      expect(payment.address.id).must_equal mock_payment_params[:payment][:address_id]
      expect(payment.card_number).must_equal mock_payment_params[:payment][:card_number]
      expect(payment.expiration_date).must_equal mock_payment_params[:payment][:expiration_date]
      expect(payment.cvv).must_equal mock_payment_params[:payment][:cvv]
      expect(payment.card_type).must_equal mock_payment_params[:payment][:card_type]

      must_redirect_to checkout_path

    end

    it "renders bad_request and does not update the DB for missing data" do
      mock_payment_params[:payment][:card_number] = nil

      expect {
                post payments_path, params: mock_payment_params
              }.wont_change 'Payment.count'

      must_respond_with :bad_request
    end

  end


end
