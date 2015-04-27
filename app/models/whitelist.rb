class Whitelist < ActiveRecord::Base
  attr_accessible :privilege, :username
end
