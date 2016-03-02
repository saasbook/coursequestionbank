Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development? or Rails.env.test?
  		provider :github, '918cb574e68f5b18bc23', '0238b8b0717604a52fec7bef153c90c21ab673cb'
	elsif Rails.env.production?
			provider :github, 'c6ca221ca8c58e5c8ea3', '6f1cc725cc56cd73e2c1f65e36e449b7419807e9'
  else
  		provider :github, '918cb574e68f5b18bc23', '0238b8b0717604a52fec7bef153c90c21ab673cb'
  	end
end
