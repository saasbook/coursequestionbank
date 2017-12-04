Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Figaro.env.github_key!, Figaro.env.github_secret!
  if Rails.env.development? or Rails.env.test?
    provider :developer, :fields => [:uid], :uid_field => [:uid]
    # see seeds.rb for available :developer logins
    SessionController.skip_before_filter :verify_authenticity_token, only: :create # to avoid problems when testing with SSL turned on with OmniAuth Developer strategy
  end
end