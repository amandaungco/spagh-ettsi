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
end
describe "create" do
  let (:review_hash) do
    {
      review: {
        date: Time.new,
        description: 'relieves anxiety',
        rating: 5
      }
    }
  end
  it "creates a work with valid data for a real category" do

    expect {
      post reviws_path, params: reviews_hash
    }.must_change 'Review.count', 1

    must_respond_with :redirect
    must_redirect_to review_path(Review.last.id)
    expect(Review.last.id).must_equal review_hash[:review][:id]
    expect(Review.last.description).must_equal review_hash[:review][:description]
  end
end 
