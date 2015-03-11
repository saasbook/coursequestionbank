class Question < ActiveRecord::Base
  attr_accessible :created_by, :created_date, :is_public, :last_used, :text
  has_and_belongs_to_many :collections
end
