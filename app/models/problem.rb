class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :text
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  
  scope :is_public, -> { where(is_public:  true) }
  scope :last_exported, ->(s, e) { where("last_used >= ? AND last_used <= ?", s, e) }

  def html5
    rb_text = "quiz '' do \n #{text} \n end"
    #puts 'TEXT IS', text
    File.open('text.rb', 'w'){|file| file.write(rb_text)}
    x = %x(ruql text.rb Html5 --template=preview.html.erb)
    #print x 
    x
  end

  def self.filter(user, filters = {})
    problems = Problem.joins(:instructor)
    if filters[:tags] and !filters[:tags].empty?
      problems = problems.joins(:tags)
    elsif filters[:collections]
      problems = problems.joins(:collections)
    end

    problems = problems.uniq.merge(Instructor.where(:id => user.id))
    
    if filters[:tags] 
      problems = problems.merge(Tag.tag_name(filters[:tags].split(",")))
    elsif filters[:collections]
      problems = problems.merge(Collection.collection(filters[:collections].keys))
    elsif filters[:last_exported]
      s = filters[:last_exported][:begin]
      e = filters[:last_exported][:end]
      problems = problems.merge(last_exported(s, e))
    end
    return problems
  end
end
