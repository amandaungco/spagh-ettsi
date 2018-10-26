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

    it 'creates a guest user' do

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
  #   it 'shows all the merchants orders' do
  #     # total orders - count
  #     # total orders.order[0] instance of oreder
  #   end
  #
  #   it 'shows all the merhcnats orders by status' do
  #     # order by paid count
  #     # order - instane of order
  #     # order.status but be paid
  #     #
  #     # orders by complete count
  #     # order - instane of order
  #     # order.status but be complete
  #   end
  #
  #   it 'shows all the merchants products' do
  #     # products
  #   end
  #
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

  # describe "it can update user status as seller" do
  #   it 'can change a users status to seller and active their products accordingly' do
  #     seller = users(:seller)
  #     perform_login(seller)
  #     patch update_user_path(seller.id), params: {
  #       user: {
  #         is_a_seller: false
  #       }
  #     }
  #     # expect login user to be a seller
  #     # expect login users products to become activate
  #     # flashes success
  #     # redirects to account point
  #   end
  #
  #   it 'can turn off a users selling status' do
  #
  #     # chane login user to turn of selling
  #     # change users products to dactivated
  #     #
  #     # it shoudl flash success account s
  #   end
  #
  end

end
