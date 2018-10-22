require "test_helper"

describe OrderProductsController do
  let(:order_one) {orders(:order_one)}
  let(:fusilli) {products(:fusilli)}
  let(:spaghetti) {products(:spaghetti)}
  let(:buyer) {users(:buyer)}
  let(:order_one_spaghetti) {order_products(:order_one_spaghetti)}
  let(:mock_params) {
    {
      order_product: {
        product_id: fusilli.id,
        quantity: 5
      }
    }
  }



  describe 'create' do
    it 'creates a row in the OrderProducts table with valid unique data and logged in user' do

      perform_login(buyer)

      expect {
            post order_products_path, params: mock_params
          }.must_change 'OrderProduct.count', 1

      must_redirect_to shopping_cart_path

    end

    it 'adds the product to the shopping cart of the logged-in user' do
      perform_login(buyer)

      expect {
            post order_products_path, params: mock_params
          }.must_change 'OrderProduct.count', 1

      new_entry = OrderProduct.last

      #the order_one fixture has the status of shopping_cart and user = buyer
      expect(new_entry.order).must_equal order_one
      expect(new_entry.product).must_equal fusilli
      expect(new_entry.quantity).must_equal 5

      must_redirect_to shopping_cart_path
    end

    it 'modifies an existing row if the product/order combo is already in the table' do

      perform_login(buyer)

      mock_params[:order_product][:product_id] = spaghetti.id

      expect(order_one_spaghetti.quantity).must_equal 5

      expect {
            post order_products_path, params: mock_params
          }.wont_change 'OrderProduct.count'

      order_one_spaghetti.reload

      expect(order_one_spaghetti.quantity).must_equal 10

      must_redirect_to shopping_cart_path

    end

    it 'does not change db with invalid data' do
      perform_login(buyer)

      mock_params[:order_product][:quantity] = nil

      expect {
            post order_products_path, params: mock_params
          }.wont_change 'OrderProduct.count'

      must_redirect_to root_path


    end

    it 'decrements the quantity in the product model appropriately' do
      perform_login(buyer)

      # fusilli wasn't already in cart
      old_quantity = fusilli.quantity

      expect {
            post order_products_path, params: mock_params
          }.must_change 'OrderProduct.count', 1

      fusilli.reload

      new_quantity = fusilli.quantity

      expect(old_quantity - new_quantity).must_equal 5

      #spaghetti was already in cart

      mock_params[:order_product][:product_id] = spaghetti.id

      old_quantity = spaghetti.quantity

      expect {
            post order_products_path, params: mock_params
          }.wont_change 'OrderProduct.count'

      spaghetti.reload

      new_quantity = spaghetti.quantity

      expect(old_quantity - new_quantity).must_equal 5

    end

  end


  describe 'check_login' do
    it 'does nothing if a user is already logged in' do
      perform_login(buyer)

      expect(session[:user_id]).must_equal buyer.id

      #call create which uses check_login as a helper method
      expect{
        post order_products_path, params: mock_params
      }.wont_change 'User.count'

      expect(session[:user_id]).must_equal buyer.id

    end

    it 'with no user logged in, creates a new guest user instance and logs the guest user in' do

      expect{
        post order_products_path, params: mock_params
      }.must_change 'User.count', 1

      new_user = User.last

      expect(new_user.full_name).must_equal 'Guest user'
      expect(new_user.email).must_equal 'example@example.com'
      expect(new_user.is_a_seller).must_equal false
      expect(new_user.provider).must_equal 'guest_login'

      expect(session[:user_id]).must_equal new_user.id
    end
  end

  describe 'check_shopping_cart' do
    it 'sets the session shopping cart id if the user has an order with shopping_cart status' do
    end

    it 'creates a new shopping cart if the user does not have one and sets the session shopping cart id' do
    end
  end

  describe 'update' do
    it 'modifies an existing row given a valid id' do
    end

    it 'fails with invalid id' do
    end

    it 'deletes row if quantity is set to zero' do
    end
  end



  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
