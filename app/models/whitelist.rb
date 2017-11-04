class Whitelist < ActiveRecord::Base
  attr_accessible :privilege, :username, :provider

  # def self.providers
  #   %w{github developer}
  # end

  # def self.privilege_levels
  #   %w{Admin Instructor Student}
  # end

  # def self.is_enabled
  #   !!Setting.whitelist
  # end

  # def self.is_enabled=(value)
  #   Setting.whitelist = !!value
  # end
end
