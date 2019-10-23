# Sidekiq.configure_server do |config|
#     config.redis = { url: ENV['REDIS_PROVIDER'], :size => 1}
    
# end

# Sidekiq.configure_client do |config|
#     config.redis = {url: ENV['REDIS_PROVIDER'], :size => 1}
    
# end

require 'sidekiq'

Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
    config.redis = { :size => 4 }
end
