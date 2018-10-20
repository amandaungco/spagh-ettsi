require "test_helper"

describe SessionsController do
  it "should get login" do
    get sessions_login_url
    value(response).must_be :success?
  end

  it "should get new" do
    get sessions_new_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get sessions_destroy_url
    value(response).must_be :success?
  end
end
