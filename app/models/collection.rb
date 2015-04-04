class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name
  has_and_belongs_to_many :problems
  belongs_to :instructor
  scope :collection, ->(collection_name) { where(name: collection_name) }
  
end
