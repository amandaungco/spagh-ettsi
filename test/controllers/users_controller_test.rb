require "test_helper"

describe UsersController do

  describe "creating users" do

    it "creates an account for a new user and redirects to the root route" do
      start_count = User.count
      #i think this is a session test
    end

    it "creates a new user" do
      start_count = User.count
      user = User.new(provider: "github", uid: 99999, full_name: "test_user", email: "test@user.com")

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      must_redirect_to root_path

      # Should have created a new user
      User.count.must_equal start_count + 1

      # The new user's ID should be set in the session
      session[:user_id].must_equal User.last.id
    end

  end

  describe 'logging in' do
    it "logs in an existing user" do
      start_count = User.count
      grace = users(:grace)
      perform_login(grace)
      must_redirect_to root_path
      session[:user_id].must_equal  grace.id

      User.count.must_equal start_count
    end

    it "logs out a user, clearing the session user id" do
      grace = users(:grace)
      perform_login(grace)

      expect(session[:user_id]).must_equal grace.id

      delete logout_path

      expect(session[:user_id]).must_equal nil
    end

  end

  describe 'user account page' do

    it 'redirects a guest from trying to access the account page' do
      @login_user = nil
      id = 1
      get user_path(id)
      must_redirect_to root_path
      expect(flash[:warning]).must_equal "Oops, you must create an account to view this page!"

    end

    it 'shows an account page for a user' do
      seller = users(:seller)
      perform_login(seller)
      get user_path(seller.id)
      must_respond_with :success
    end

    it 'allows a user to become a seller/merchant' do
      buyer = users(:buyer)
      perform_login(buyer)
      patch update_user_path(buyer.id), params: {
        user: {
          is_a_seller: true
        }
      }
      must_redirect_to account_path
      expect(flash[:success]).must_equal"Account settings updated!"

    end

  end

  describe 'merchant user settings' do

    it 'shows a dashbboard of a merchants store' do
      seller = users(:seller)
      perform_login(seller)
      get dashboard_path
      must_respond_with :success
    end

    it 'redirects a guest user from seeing a dashboard' do
      get dashboard_path
      must_redirect_to root_path
      expect(flash[:warning]).must_equal"You don't have permission to view that page"

    end

    it 'redirects a non-seller user from seeing a dashboard' do
      buyer = users(:buyer)
      perform_login(buyer)
      get dashboard_path
      must_redirect_to root_path
      expect(flash[:warning]).must_equal"You don't have permission to view that page"
    end

  end

  describe 'merchant dashboard' do
    it 'shows all the merchants products' do
      seller = users(:seller)
      perform_login(seller)
      get merchant_my_products_path
      must_respond_with :success
    end
  end
  #   it 'shows all the merchants products by status' do
  #     # active. count
  #     # instance of
  #     # produt .name
  #     #
  #     # inactive
  #     # instance of
  #     # product.name
  #   end
  #
  #   it 'renders not found for orders that havent been placed/are in shopping cart' do
  #
  #   end
  #
  #   it 'renders not found for orders that do not exist' do
  #
  #   end
  #
  #   it 'shows the order_product row specific to the merhcnat for an order' do
  #
  #   end
  #
  #   it 'shows their subtotal for the row of their order for an order' do
  #
  #   end
  #
  # end

  describe "it can update user status as seller" do

    it 'can turn off seller status and deactive their products accordingly' do
      seller = users(:seller)
      perform_login(seller)
      patch update_user_path(seller.id), params: {
        user: {
          is_a_seller: false
        }
      }
      expect(seller.products[1].is_active).must_equal false

      must_redirect_to account_path
      expect(flash[:success]).must_equal "Account settings updated!"
    end

    it 'can turn on a users selling status and reactivate products' do
      seller = users(:seller)
      perform_login(seller)
      patch update_user_path(seller.id), params: {
        user: {
          is_a_seller: true
        }
      }
      expect(seller.products[0].is_active).must_equal true

      must_redirect_to account_path
      expect(flash[:success]).must_equal "Account settings updated!"
    end

  end

  describe "it shows orders that merchants need to fulfill" do

    it 'finds an order a merchant needs to fulfill' do
      seller = users(:seller)
      order = orders(:order_two)
      perform_login(seller)
      get merchant_order_path(order.id)
      must_respond_with :success
    end

    # it 'renders not found for a merchants products that are still in the shopping ' do
    #   seller = users(:seller)
    #   order = orders(:order_one)
    #   perform_login(seller)
    #   get merchant_order_path(order.id)
    #   must_respond_with :not_found
    # end
  end
end
