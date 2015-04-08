class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :rendered_text, :text 
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  
  scope :is_public, -> { where(is_public:  true) }
  scope :last_used, ->(time) { where("last_used < ?", time) }
  scope :instructor_id, ->(id) { where(instructor_id: id) }
  

  searchable do
    integer   :id
    text      :text
    integer   :instructor_id
    boolean   :is_public
    time      :last_used
    
    string    :tag_names, :multiple => true do
      tags.map(&:name)
    end

    string    :coll_names, :multiple => true do
      collections.map(&:name)
    end 

  end

  def html5
    @readonly = false #hack
    if rendered_text
      return rendered_text 
    end
    rb_text = "quiz '' do \n #{text} \n end"
    File.open('text.rb', 'w'){|file| file.write(rb_text)}
    html5_text = %x(ruql text.rb Html5 --template=preview.html.erb)
    self.update_attributes(:rendered_text => html5_text)
    html5_text

  end

  def self.filter(user, filters = {})
<<<<<<< HEAD
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
=======
    #problems = Problem.joins(:instructor, :tags, :collections).uniq.merge(Instructor.where(:id => user.id))
    #if filters[:tags] and !filters[:tags].empty?
    #  problems = problems.merge(Tag.tag_name(filters[:tags].split(",")))
    #elsif filters[:collections]
    #  problems = problems.merge(Collection.collection(filters[:collections].keys))
    #end

    if !filters[:tags]
      filters[:tags] = ""
    end

    if !filters[:collections]
      filters[:collections] = {}
    end


    problems = Problem.search do
      any_of do
        with(:instructor_id, 1)
        with(:is_public, true)
      end

      with(:tag_names, filters[:tags].split(","))
      with(:coll_names, filters[:collections].keys)
      fulltext filters[:search]
>>>>>>> 3242ac3f987748117cdb1fbe551725a709e8ece5
    end
    return problems.results
  end
end
