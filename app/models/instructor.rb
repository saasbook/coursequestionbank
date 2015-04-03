class Instructor < ActiveRecord::Base

  attr_accessible :privilege, :name, :uid, :provider
  has_many :collections
  has_many :problems
  
  scope :username, ->(instructor) { where(name: instructor) }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.privilege = "admin"
    end
  end

end
