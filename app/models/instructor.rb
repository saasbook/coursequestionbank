class Instructor < ActiveRecord::Base

  attr_accessible :name, :username, :uid, :provider, :provider_image, :provider_email, :current_collection
  has_many :collections
  has_many :problems

  scope :username, ->(instructor) { where(name: instructor) }
  scope :nonadmin, -> { where(privilege: "default") }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      if auth["info"]["name"] and !auth["info"]["name"].empty?
        user.name = auth["info"]["name"]
      else
        user.name = auth["info"]["nickname"]
      end
      user.username = auth["info"]["nickname"]
      user.provider_image = auth["info"]["image"]
      user.provider_email = auth["info"]["email"]
      # @whitelisted_user = Whitelist.find_by_username(user.username)
      @whitelisted_user = Whitelist.create(username: user.username, privilege: "instructor")
      user.privilege = @whitelisted_user.privilege if @whitelisted_user
      user.privilege ||= "default"
    end
  end

  def admin?
    return privilege == "admin"
  end

  def instructor?
    return privilege == "instructor"
  end
end
