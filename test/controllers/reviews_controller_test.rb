require "test_helper"

describe ReviewsController do
  it 'succeeds' do
    get reviews_path

    must_respond_with :success
  end
end
