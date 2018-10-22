require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    let(:grace) {users(:grace)}
    it "logs in an existing user and redirects to the root route" do
      expect{perform_login(grace)}.wont_change('User.count')
      # start_count = User.count
      # user = users(:grace)
      #
      # perform_login(user)
      must_redirect_to root_path
      expect(session[:user_id]).must_equal  grace.id
      #
      # # Should *not* have created a new user
      # User.count.must_equal start_count
    end
  end

  it "creates an account for a new user and redirects to the root route" do
    start_count = User.count
    user = User.new(provider: "github", uid: 99999, full_name: "test_user", email: "test@user.com")

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
    get auth_callback_path(:github)

    must_redirect_to root_path

    # Should have created a new user
    User.count.must_equal start_count + 1

    # The new user's ID should be set in the session
    session[:user_id].must_equal User.last.id
  end

  it "redirects to the login route if given invalid user data" do
  end

end
