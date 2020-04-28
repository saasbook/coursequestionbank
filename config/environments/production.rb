Coursequestionbank::Application.configure do
  config.active_support.deprecation = :notify
  config.assets.compile = false # for production/Heroku, and to close serious CVE-2018-3760
end
