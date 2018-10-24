require "test_helper"

describe AddressesController do
  let(:buyer) {users(:buyer)}
  let(:seller) {users(:seller)}
  let(:mock_params) {
    {
      address: {
        user_id: buyer.id,
        first_name: "Gunther",
        last_name: "Centralperk",
        street: "Central Perk",
        street_2: nil,
        city: "New York",
        state: "NY",
        zip: 10001
      }
    }
  }


  describe "new" do

    it "succeeds when user is logged in" do
      perform_login(buyer)
      get new_address_path
      must_respond_with :success
    end

    it 'responds with bad request and redirects with no user logged in' do
      get new_address_path
      must_redirect_to 'layouts/not_found'
      must_respond_with :bad_request

    end
  end

  describe "create" do

      it "creates an address with valid data with a logged in user" do
        perform_login(buyer)

        expect {
                  post addresses_path, params: mock_params
                }.must_change 'Address.count', 1

        address = Address.last

        expect(address.user_id).must_equal mock_params[:address][:user_id]
        expect(address.first_name).must_equal mock_params[:address][:first_name]
        expect(address.last_name).must_equal mock_params[:address][:last_name]
        expect(address.street).must_equal mock_params[:address][:street]
        expect(address.street_2).must_equal mock_params[:address][:street_2]
        expect(address.city).must_equal mock_params[:address][:city]
        expect(address.state).must_equal mock_params[:address][:state]
        expect(address.zip).must_equal mock_params[:address][:zip]

        must_redirect_to checkout_path

      end

      it "responds with bad request if address user is not logged in user" do
        perform_login(seller)

        expect {
                  post addresses_path, params: mock_params
                }.wont_change 'Address.count'

    
        must_respond_with :bad_request

      end


      it "renders bad_request and does not update the DB for bogus data" do
        perform_login(buyer)

        mock_params[:address][:street] = nil

        expect {
                  post addresses_path, params: mock_params
                }.wont_change 'Address.count'

        must_respond_with :bad_request
      end

      it "renders bad_request and does not update the DB if no user is logged in" do

        expect {
                  post addresses_path, params: mock_params
                }.wont_change 'Address.count'

        must_respond_with :bad_request
      end

    end


end
