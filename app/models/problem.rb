class Problem < ActiveRecord::Base
  attr_accessible :created_by, :created_date, :is_public, :last_used, :text
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :instructors
  has_and_belongs_to_many :collections
  
  def html5
    text = "question '' do + \n" + self.text + '\n end'
    %x(echo text > text.rb) #writes this to text.rb file since ruql prefers files
    %x(ruql text.rb Html5 --template=preview.html.erb)
  end
end
