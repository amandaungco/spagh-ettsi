require "test_helper"

describe OrderProductsController do
  let(:order_one) {orders(:order_one)}
  let(:mock_params) {
    order_product: {
      order_id: order_one.id
      product: spaghetti
        quantity: 5
    }
  }
  describe 'create' do
    it 'creates a row in the OrderProducts table with valid unique data' do

    end

    it 'modifies an existing row if the product/order combo is already in the table' do
    end

    it 'fails with invalid data' do
    end

    it 'decrements the quantity in the product model appropriately' do
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

  describe 'check_login' do
    it 'does nothing if a user is already logged in' do
    end

    it 'creates a new guest user instance and logs the guest user in' do
    end
  end

  describe 'check_shopping_cart' do
    it 'sets the session shopping cart id if the user has an order with shopping_cart status' do
    end

    it 'creates a new shopping cart if the user does not have one and sets the session shopping cart id' do
    end
  end


  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
