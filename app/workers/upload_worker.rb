require 'sidekiq'
require 'sidekiq-status'
class UploadWorker
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options queue: "high"
    sidekiq_options retry:false
    def perform (user_id, file)
        current_user = Instructor.find_by_id(user_id)
        RuqlReader.store_as_json(current_user, file)
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