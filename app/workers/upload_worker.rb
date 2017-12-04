require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq/api'
class UploadWorker
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options queue: "high"
    sidekiq_options retry:false
    def perform (user_id, file)
        Sidekiq::Queue.new.clear
        puts "INSIDE perform: file: #{file}"
        RuqlReader.store_as_json(user_id, file)
    end
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    # accepts :expiration (optional)
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes # default
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    # accepts :expiration (optional)
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.client_middleware do |chain|
    # accepts :expiration (optional)
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes # default
  end
end