require "test_helper"

describe ProductsController do
  let(:spaghetti) {products(:spaghetti)}
  let(:lasagne) {products(:lasagne)}
  let(:seller) {users(:seller)}

  let(:mock_params) {
      {
        product:
          {
            name: 'ziti',
            user_id: seller.id,
            price_in_cents: 349,
            category: 'short',
            quantity: 100,
            description: 'these ones are ziti'
          }
      }
    }

  describe 'index' do
    it 'succeeds' do
      get products_path

      must_respond_with :success
    end

  end

  describe 'show' do
    it 'succeeds given a valid ID' do
      get product_path(spaghetti.id)

      must_respond_with :success
    end

    it 'responds with not found given an invalid ID' do
      get product_path(-1)

      must_respond_with :not_found
    end
  end

  describe 'new' do
    it 'succeeds' do
      get new_product_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'creates a new product with valid data' do

      expect {
            post products_path, params: mock_params
          }.must_change 'Product.count', 1

      product = Product.last

      expect(product.name).must_equal mock_params[:product][:name]
      expect(product.user_id).must_equal mock_params[:product][:user_id]
      expect(product.price_in_cents).must_equal mock_params[:product][:price_in_cents]
      expect(product.category).must_equal mock_params[:product][:category]
      expect(product.quantity).must_equal mock_params[:product][:quantity]
      expect(product.description).must_equal mock_params[:product][:description]

      must_redirect_to product_path(product.id)

    end

    it "renders bad_request and does not update the DB for bogus data" do
      mock_params[:product][:user_id] = nil

      expect {
                post products_path, params: mock_params
              }.wont_change 'Product.count'

      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "succeeds with valid id" do
      get product_path(spaghetti.id)

      must_respond_with :success
    end

    it "renders 404 not_found for an invalid id" do
      get product_path(-1)

      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "succeeds with valid id" do
      get edit_product_path(spaghetti.id)

      must_respond_with :success

    end

    it "renders 404 not_found for an invalid id" do
      get edit_product_path(-1)

      must_respond_with :not_found
    end
  end
end
