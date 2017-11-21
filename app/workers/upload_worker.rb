#require 'sidekiq'
#class UploadWorker
    #include Sidekiq::Worker
    #sidekiq_options queue: "high"
   # sidekiq_options retry:false
 #   def perform (user_id, file, controller)
  #      current_user = Instructor.find_by_id(user_id)
 #       RuqlReader.store_as_json(current_user, file)
 #       byebug
 #       controller.redirect_to "/problems"
#    end
#end