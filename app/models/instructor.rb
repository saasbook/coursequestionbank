class Instructor < ActiveRecord::Base
  attr_accessible :name, :last_used, :privilege, :uid, :provider
  has_many :questions, :collections
end

