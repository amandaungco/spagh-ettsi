require "test_helper"
require "pry"
describe ReviewsController do
  it 'succeeds' do
    get reviews_path

    must_respond_with :success
  end

  it "should show all the reviews" do
    get reviews_index_url
    value(response).must_be :success?
  end


  it "should create a new review with valid fields" do

  end
end
