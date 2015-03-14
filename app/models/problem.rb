class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :text
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  
  scope :is_public, -> { where(is_public:  true) }
  scope :last_used, ->(time) { where("last_used < ?", time) }

  def html5
    rb_text = "quiz '' do \n #{text} \n end"
    puts 'TEXT IS', text
    File.open('text.rb', 'w'){|file| file.write(rb_text)}
    x = %x(ruql text.rb Html5 --template=preview.html.erb)
    print x 
    x
  end
end
