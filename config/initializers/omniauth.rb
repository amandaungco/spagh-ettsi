Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email", callback_path:'/auth/github/callback'
end
OmniAuth.config.test_mode = true
