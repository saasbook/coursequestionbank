class Tag < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :problems

  scope :tag_name, ->(t) { where(name: t) }
end
