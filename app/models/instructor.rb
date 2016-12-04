class Instructor < ActiveRecord::Base

  attr_accessible :name, :username, :uid, :provider, :provider_image, :provider_email, :privilege, :collections, :problem

  has_many :collections
  has_many :problems
  has_many :studentanswers
  
  def self.dev_users
    where(:provider => "developer")
  end

  def self.create_via_omniauth(auth)
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
      user.privilege = "Student"
    end
  end

  # def admin?
  #   privilege == "Admin"
  # end
  #
  # def instructor?
  #   privilege == "Instructor"
  # end
  #
  # def student?
  #   privilege == "Student"
  # end

  # The new data structure stores privilege information in Instructor
  # To prevent data loss, the old whitelist table is preseved.
  # If the privilege attribute is nil in instructor table, find that user in whitelist
  # And set his privilege in instructor table as in whitelist
  # If somehow a user's privilege is nil in instructors and whitelist table
  # set him as Student
  # (this should not happen in practice, though)
  def get_privilege
    if self.privilege.nil?
      whitelist = Whitelist.find_by_username_and_provider(username, provider)
      if whitelist
        self.privilege = whitelist.privilege.capitalize
      else
        self.privilege = "Student"
      end
    end
    return self.privilege
  end

  def self.privilege_levels
    %w{Admin Instructor Student}
  end

end
