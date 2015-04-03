class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name
  has_and_belongs_to_many :problems
  belongs_to :instructors
  scope :collection, ->(collection_name) { where(name: collection_name) }
  
  def self.collections_for_user(user)
  	collections = Set.new
    user.problems.each { |p| collections.merge(p.collections)  }
    collections
  end

end
