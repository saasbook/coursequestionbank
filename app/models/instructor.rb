class Instructor < ActiveRecord::Base
  attr_accessible :privilege, :username
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :problems
end
