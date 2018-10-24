require "test_helper"
require "pry"

describe ReviewsController do
  it 'succeeds' do
    get reviews_path

    must_respond_with :success
  end

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

  it "should create a new review" do
    get new_review_path

    must_respond_with :success
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

      perform_login(users(:buyer))

      expect {
        post reviews_path, params: review_hash
      }.must_change 'Review.count', 1

      must_redirect_to reviews_path
    end
  end
end
