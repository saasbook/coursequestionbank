class Collection < ActiveRecord::Base
  attr_accessible :name, :last_used
  has_and_belongs_to_many :questions
end

