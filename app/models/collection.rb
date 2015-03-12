class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name
  has_and_belongs_to_many :questions
end
