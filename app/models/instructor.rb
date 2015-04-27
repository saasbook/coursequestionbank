class Instructor < ActiveRecord::Base

  attr_accessible :privilege, :name, :uid, :provider, :provider_image, :provider_email, :current_collection 
  has_many :collections
  has_many :problems
  
  scope :username, ->(instructor) { where(name: instructor) }
  scope :nonadmin, -> {where(privilege: "default")}

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      if !auth["info"]["name"].empty?
        user.name = auth["info"]["name"]
      else
        user.name = auth["info"]["nickname"]
      end
      user.provider_image = auth["info"]["image"]
      user.provider_email = auth["info"]["email"]
      if Instructor.all.size == 0 #to make sure that the first user is admin
        user.privilege = "admin"
      else
        user.privilege = "default"
      end
    end
  end

  def admin?
    privilege == "instructor" || privilege == "admin"
  end
end
