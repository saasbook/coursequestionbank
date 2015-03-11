Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.development? or Rails.env.test?
  		provider :github, '1697958983c6320f708f', 'efa6306331ad08250cf380d9f25a84336f9b34cd'
  	else
  		provider :github, '8cbb590d480c4dd80442', '8a4c2ff770cecf63a51b1cfb9db9a00709c0045c'
  	end
end