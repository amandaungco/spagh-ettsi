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
        price_in_cents: 3.49,
        category: 'short',
        quantity: 100,
        description: 'these ones are ziti'
      }
    }
  }

  describe 'guest users' do
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


    describe 'guest restrictions' do

      it "cannot access new" do
        get new_product_path
        must_redirect_to root_path
        expect(flash[:warning]).must_equal "You must be a merchant to sell a product. Sign up as a merchant to continue!"
      end
    end
  end


  describe 'authorized and logged in user functionality' do
    let(:seller) {users(:seller)}
    let(:buyer) {users(:buyer)}

    describe 'logged in user that is not a seller' do

      it 'does not allow a non-seller user to create a new product' do
        perform_login(buyer)
        get new_product_path
        must_redirect_to user_path(buyer.id)
        expect(flash[:warning]).must_equal "You must be a merchant to sell a product. Sign up as a merchant to continue!"
      end
    end

    describe "logged in user that is a seller" do

      describe 'new and create' do
        it 'allows a seller user to create a new product' do
          perform_login(seller)
          get new_product_path
          assert_response :success

          expect {
            post products_path, params: mock_params
          }.must_change 'Product.count', 1

          product = Product.last

          expect(product.name).must_equal mock_params[:product][:name]
          expect(product.user_id).must_equal seller.id
          expect(product.price_in_cents).must_equal 349
          expect(product.category).must_equal mock_params[:product][:category]
          expect(product.quantity).must_equal mock_params[:product][:quantity]
          expect(product.description).must_equal mock_params[:product][:description]

          must_redirect_to product_path(product.id)

        end

        it "renders bad_request and does not update the DB for bogus data" do
          mock_params[:product][:price_in_cents] = 'words'
          perform_login(seller)


          expect {
            post products_path, params: mock_params
          }.wont_change 'Product.count'

          must_respond_with :bad_request
        end
      end

    end



    describe "edit for product created by user" do
      #login user as seller
      #user product that belongs to the seller

      it "succeeds with valid id that belongs to them" do
        perform_login(seller)
        get edit_product_path(spaghetti.id)

        must_respond_with :success

      end

      it "renders 404 not_found for an invalid id" do
        #create a product is theirs
        #delete products, run this test
        perform_login(seller)
        get edit_product_path(-1)

        must_respond_with :not_found
      end

      it "doesn't allow a user that is not a seller to edit a valid item" do
        #try editing a product that is not theirs and gives error messages
        perform_login(buyer)
        get edit_product_path(spaghetti.id)
        must_redirect_to root_path
        expect(flash[:warning]).must_equal "You don't have permission to see that."
      end

      it "fails with valid id that does not belong to them" do
        ada = users(:ada)#try editing a product that is not theirs and gives error messages
        perform_login(ada)
        get edit_product_path(spaghetti.id)
        must_redirect_to root_path
        expect(flash[:warning]).must_equal "You can only edit your own products."
      end
    end

    describe "update product" do
      it 'can update a product' do
        mock_product_params = {
          product: {
            quantity: 30,
            price_in_cents: 5.99
          }
        }

        lasagne = products(:lasagne)
        expect(lasagne.quantity).must_equal 25
        perform_login(seller)

        expect{
          patch product_path(lasagne.id), params: mock_product_params
          #binding.pry
        }.must_change 'lasagne.reload.quantity', 5

        must_redirect_to product_path(lasagne.id)
        expect(flash[:success]).must_equal "Successfully updated lasagne"
        expect(lasagne.quantity).must_equal 30
        expect(lasagne.price_in_cents).must_equal 599
      end

      it 'can flashes an error for invalid params for updating a product' do
        mock_product_params = {
          product: {
            quantity: -2,
            price_in_cents: 5.99
          }
        }

        lasagne = products(:lasagne)
        expect(lasagne.quantity).must_equal 25
        perform_login(seller)

        expect{
          patch product_path(lasagne.id), params: mock_product_params
        }.wont_change 'lasagne.reload.quantity'

        expect(flash[:warning]).must_equal "A problem occurred: Could not update lasagne"
        expect(lasagne.quantity).must_equal 25
        expect(lasagne.price_in_cents).must_equal 499
      end
    end

    describe 'deactivate products' do
      it 'prevents a guest user from deactivating a product' do

        patch deactivate_product_path(lasagne.id)

        must_redirect_to root_path
        expect(flash[:warning]).must_equal "You don't have permission to see that."
      end
    end


  end
end
