require "test_helper"

describe OrdersController do
  let(:order_one) {orders(:order_one)}
  let(:order_two) {orders(:order_two)}
  let(:order_three) {orders(:order_three)}
  let(:buyer) {users(:buyer)}

  let(:order_params) {
    {
      order: {
        payment_id: payments(:amex).id,
        address_id: addresses(:school).id,
        status: :paid
      }
    }
  }

  describe 'show' do
    it 'succeeds with a logged-in user viewing their own non-pending order given a valid ID' do
      perform_login(buyer)
      get order_path(order_two.id)

      must_respond_with :success
    end

    it 'responds with not found with a logged-in user trying to view a pending order given a valid ID' do
      perform_login(buyer)
      get order_path(order_one.id)

      must_respond_with :not_found
    end

    it 'responds with not found with a logged-in user trying to view someone elses order with valid ID' do
      perform_login(buyer)
      get order_path(order_three.id)

      must_respond_with :not_found
    end

    it 'responds with not found with a logged-in user given an invalid ID' do
      perform_login(buyer)
      get order_path(-1)

      must_respond_with :not_found
    end

    it 'redirects to root if a user is not logged in given a valid ID' do
      get order_path(order_two.id)

      must_redirect_to root_path
    end
  end

  describe 'edit, which is actually checkout form' do
    it 'succeeds with a logged-in user given a pending order with valid ID' do
      perform_login(buyer)
      get edit_order_path(order_one.id)

      must_respond_with :success
    end

    it 'responds with not found with a logged-in user given a non-pending order with valid ID' do
      perform_login(buyer)
      get edit_order_path(order_two.id)

      must_respond_with :not_found
    end

    it 'responds with not found with a logged-in user with someone elses valid order ID' do
      perform_login(buyer)
      get edit_order_path(order_three.id)

      must_respond_with :not_found
    end

    it 'redirects to root with no user logged in (guest user is technically a login)' do
      get edit_order_path(order_three.id)

      must_redirect_to root_path
    end

  end

  describe 'mark_as_shipped' do
  end

  describe 'update'  do
    it 'updates the order with a logged-in user given valid data and redirects to order show page' do
      perform_login(buyer)
      patch order_path(order_one.id), params: order_params

      must_redirect_to order_path(order_one.id)
    end

    it 'responds with bad request with logged-in user given invalid data' do
      perform_login(buyer)
      order_params[:order][:payment_id] = nil

      patch order_path(order_one.id), params: order_params

      must_respond_with :bad_request
    end

    it 'redirects to root path with no login user' do
      patch order_path(order_one.id), params: order_params

      must_redirect_to root_path
    end

  end


end
