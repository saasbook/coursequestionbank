class Whitelist < ActiveRecord::Base
  attr_accessible :privilege, :username, :provider
end
