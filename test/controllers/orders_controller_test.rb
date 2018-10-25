require "test_helper"

describe OrdersController do
  let(:order_one) {orders(:order_one)}
  let(:order_two) {orders(:order_two)}
  let(:order_three) {orders(:order_three)}
  let(:buyer) {users(:buyer)}
  let(:seller) {users(:seller)}

  let(:order_params) {
    {
      order: {
        payment_id: payments(:amex).id,
        address_id: addresses(:school).id,
        status: :paid
      }
    }
  }

  let(:op_params) {
    {
      order_product: {
        product_id: products(:fusilli).id,
        quantity: 5
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

    it 'clears the session to remove a guest login after displaying order summary' do
      post order_products_path, params: op_params  #start a shopping cart to create guest login
      new_order = Order.last
      expect(new_order.user.provider).must_equal 'guest_login'

      patch order_path(new_order.id), params: order_params #complete the order

      get order_path(new_order.id)

      expect(session[:user_id]).must_equal nil
    end
  end

  describe 'edit, which is actually checkout form' do
    it 'succeeds with a logged-in user given a pending order with valid ID' do
      perform_login(buyer)
      get edit_order_path(order_one.id)

      must_respond_with :success
    end

    it 'succeeds as checkout_path when a user has a pending order' do
      perform_login(buyer)
      get checkout_path

      must_respond_with :success
    end

    it 'responds with not found if a user has no pending order' do
      perform_login(seller)
      get checkout_path
      must_respond_with :not_found
    end


    # it 'responds with not found with a logged-in user given a non-pending order with valid ID' do
    #   perform_login(buyer)
    #   get edit_order_path(order_two.id)
    #
    #   must_respond_with :not_found
    # end
    #changed edit path to checkout so overrides this capability
    #
    # it 'responds with not found with a logged-in user with someone elses valid order ID' do
    #   perform_login(buyer)
    #   get edit_order_path(order_three.id)
    #
    #   must_respond_with :not_found
    # end

    it 'redirects to root with no user logged in (guest user is technically a login)' do
      get edit_order_path(order_three.id)

      must_redirect_to root_path
    end

  end

  describe 'mark_as_shipped' do
    it 'changes order status from paid to shipped with logged in user and valid ID' do
      perform_login(seller)

      expect(order_two.status).must_equal 'paid'

      patch mark_as_shipped_path(order_two.id)

      order_two.reload
      expect(order_two.status).must_equal 'complete'
    end

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

    it 'prevents checkout with an empty cart' do
      perform_login(buyer)
      order_one.order_products.each do |op|
        op.delete
      end
      post checkout_path, params: order_params

      must_redirect_to products_path
    end

  end


end
