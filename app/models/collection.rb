class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :problems
  belongs_to :instructor
  scope :collection, ->(collection_name) { where(name: collection_name) }
  
  def self.create_collection(params, current_user)
    @collection = Collection.create params
    current_user.update_attributes(:current_collection => @collection.id)
    @collection.instructor =  current_user
    @collection.created_at = DateTime.now
    @collection.save
  end

  def add_to_collection(problem)
    if problems.include? problem
      return false
    else 
      update_attributes(problem)
    end
  end
end
