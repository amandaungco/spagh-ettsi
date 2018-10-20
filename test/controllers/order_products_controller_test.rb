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

  end


  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
