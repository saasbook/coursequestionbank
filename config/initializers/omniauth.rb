Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development? or Rails.env.test?
  		provider :github, '9a486077b6009822c7fc', '1b1a6c928849e18152ba49c4011aac7de2d10b7c'
	elsif Rails.env.production?
			provider :github, 'c6ca221ca8c58e5c8ea3', '6f1cc725cc56cd73e2c1f65e36e449b7419807e9'
  else
  		provider :github, '9a486077b6009822c7fc', '1b1a6c928849e18152ba49c4011aac7de2d10b7c'
  	end
end
