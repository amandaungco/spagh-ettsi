require "test_helper"
require "pry"

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

      get new_review_path

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

      perform_login(users(:buyer))

      expect {
        post reviews_path, params: review_hash
      }.must_change 'Review.count', 1

      must_redirect_to reviews_path
    end

    it "renders bad_request when invalid data is provided" do

      perform_login(users(:buyer))
      # Arranges
      review_hash[:review][:rating] = nil

      # Act-Assert
      expect {
        post reviews_path, params: review_hash
      }.wont_change 'Review.count'

      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "succeeds for an existing review" do
      # Arrange
      id = reviews(:one).id

      # Act
      get review_path(id)

      # Assert
      must_respond_with :success
    end

    it "renders 404 not_found for a non-existing review" do
    let(:product) { products(:spaghetti) }
      let(:review_hash) do
        binding.pry 
        {
          review: {
            review: 'relieves anxiety',
            rating: 5,
            product_id: product.id
          }
        }
      end
      # Arrange - invalid id
      id = review_hash[:review][:rating] = nil

      # Act
      get review_path(id)

      # Assert
      must_respond_with :not_found
      # end
    end
  end
end
