class Question < ActiveRecord::Base
  attr_accessible :text, :created_date, :created_by, :is_public, :last_used
  has_and_belongs_to_many :collections, :tags
end
