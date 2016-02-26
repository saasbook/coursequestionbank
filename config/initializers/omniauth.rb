Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development? or Rails.env.test?
  		provider :github, '918cb574e68f5b18bc23', '0238b8b0717604a52fec7bef153c90c21ab673cb'
  	else
  		provider :github, '918cb574e68f5b18bc23', '0238b8b0717604a52fec7bef153c90c21ab673cb'
  	end
end