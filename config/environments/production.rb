Coursequestionbank::Application.configure do

  config.without_solr = true

  config.active_support.deprecation = :notify
  config.eager_load = false
  config.force_ssl = true
end
