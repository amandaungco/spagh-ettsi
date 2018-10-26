require "test_helper"


describe ReviewsController do
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

  describe "show" do
    it "can find a review" do

      @review = Review.find_by(id: @product_id)

      get reviews_url
      value(response).must_be :successful?
    end
  end

  describe "new" do
    # let(:spaghetti) {products(:spaghetti)}
    # let(:seller) {users(:seller)}
    it "succeeds" do

      get reviews_path

      must_respond_with :success
    end

    it "checks the owner cannot review their own product" do
      @product.user_id = 130
      @login_user_id = 130
      expect(@product.user_id == @login_user_id)
      # expect(@login_user.id != @product.user_id)
       # expect(@item_ownership).must_equal :valid
      # @review = Review.find_by(id: @product_id)

      must_redirect_to product_path(@product_id)

      must_respond_with :warning
    end
  end

  describe "create" do
    let(:review_hash) do
      {
        review: {
          review: 'relieves anxiety',
          rating: 5,
          product_id: product.id
        }
      }

      it "creates a review if valid data is provided" do
        expect {
          post reviews_path, params: review_hash
        }.must_change 'Review.count', 1

        must_redirect_to product_path(@product.id)
      end

      it "renders not_found when invalid data is provided" do

        # Arranges
        review_hash[:review][:rating] = nil

        # Act-Assert
        expect {
          post reviews_path, params: review_hash
        }.wont_change 'Review.count'

        get product_path(-1)

        must_respond_with :not_found
      end
    end
  end
end
