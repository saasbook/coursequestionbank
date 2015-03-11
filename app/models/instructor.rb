class Instructor < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :privilege
  has_many :questions, :collections
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.privilege = "admin"
    end
  end
end
