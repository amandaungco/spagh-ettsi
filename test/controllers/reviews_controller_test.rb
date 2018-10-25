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
  describe "new" do
    it "succeeds" do

      get reviews_path

      must_respond_with :success
    end
  end

  describe "create" do
    let(:product) { products(:spaghetti) }

    let(:review_hash) do
      {
        review: {
          review: 'relieves anxiety',
          rating: 5,
          product_id: product.id
        }
      }
    end

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

      must_respond_with :not_found
    end
  end
end
