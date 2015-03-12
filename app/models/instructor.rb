class Instructor < ActiveRecord::Base
  has_many :questions
  has_many :collections
  
  attr_accessible :name, :provider, :uid, :privilege
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.privilege = "admin"
    end
  end
end
