require "test_helper"

describe ReviewsController do
  let(:spaghetti) {products(:spaghetti)}
  let(:seller) {users(:seller)}
  let(:review_hash) do
    {
      review: {
        review: 'relieves anxiety',
        rating: 5,

        product_id: spaghetti.id
      }
    }
  end
  it 'succeeds' do
    get reviews_path

    must_respond_with :success
  end

  describe "index" do
    it "index action should show all the reviews" do
      @reviews = Review.all

      get reviews_url
      value(response).must_be :successful?
    end

    it "should display no reviews when there are no reviews" do
      Review.destroy_all

      get reviews_path
      must_respond_with :success
      expect(Review.all.count).must_equal 0
    end
  end


  describe "new" do

    it "succeeds" do

      get new_product_review_path(spaghetti.id)

      must_respond_with :success
    end

    it "checks the owner cannot review their own product" do
      perform_login(seller)
      get new_product_review_path(spaghetti.id)

      must_redirect_to product_path(spaghetti.id)
    end

      it "responds with not_found with a bad id" do
        get new_product_review_path(-1)

        must_respond_with :not_found
      end
  end

  describe "create" do
    it "creates a review if valid data is provided" do
      expect {
        post create_review_path(spaghetti.id), params: review_hash
      }.must_change 'Review.count', 1

      must_redirect_to product_path(spaghetti.id)
    end

    it "renders not_found when invalid data is provided" do

      # Arranges
      review_hash[:review][:rating] = nil

      # Act-Assert
      expect {
        post create_review_path(spaghetti.id), params: review_hash
      }.wont_change 'Review.count'

      get product_path(-1)

      must_respond_with :not_found
    end
    it "checks the owner cannot review their own product" do
      perform_login(seller)
      expect {
        post create_review_path(spaghetti.id), params: review_hash
      }.wont_change 'Review.count'

      must_redirect_to product_path(spaghetti.id)
    end
  end

end
