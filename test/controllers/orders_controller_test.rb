require "test_helper"

describe OrdersController do
  let(:order_one) {orders(:order_one)}

  let(:order_params) {
    {
      order: {
        payment_id: payments(:amex).id,
        address_id: addresses(:school).id
      }
    }
  }

  describe 'show' do
    it 'succeeds given a valid ID' do
      get order_path(order_one.id)

      must_respond_with :success
    end

    it 'responds with not found given an invalid ID' do
      get order_path(-1)

      must_respond_with :not_found
    end
  end

  describe 'edit' do
    it 'succeeds with a logged-in user given a pending order with valid ID' do
      get edit_order_path(order_one.id)

      must_respond_with :success
    end

    it 'responds with not found given an invalid ID' do
      get edit_order_path(-1)

      must_respond_with :not_found
    end

  end

  describe 'mark_as_shipped' do
  end

  describe 'update'  do
  end




end
