Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :github, 'c6ca221ca8c58e5c8ea3', '6f1cc725cc56cd73e2c1f65e36e449b7419807e9' # Heroku keys
  elsif Rails.env.development? or Rails.env.test?
    provider :developer, :fields => [:uid], :uid_field => [:uid]         # see seeds.rb for available :developer logins 
    SessionController.skip_before_filter :verify_authenticity_token, only: :create # to avoid problems when testing with SSL turned on with OmniAuth Developer strategy

    provider :github, '9a486077b6009822c7fc', '1b1a6c928849e18152ba49c4011aac7de2d10b7c' # localhost:3000
  else                          # ?? when would this happen??
    provider :github, '918cb574e68f5b18bc23', '0238b8b0717604a52fec7bef153c90c21ab673cb'
  end
end
