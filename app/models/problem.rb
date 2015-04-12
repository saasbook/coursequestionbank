class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :rendered_text, :text, :json
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  

  scope :is_public, -> { where(is_public:  true) }
  scope :last_used, ->(t) { where(last_used: t) }
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

    if !filters[:last_exported_begin] or filters[:last_exported_end].empty?
      filters[:last_exported_begin] = nil
    end
    if !filters[:last_exported_end] or filters[:last_exported_end].empty?
      filters[:last_exported_end] = nil
    end


    problems = Problem.search do
      any_of do
        with(:instructor_id, 1)
        with(:is_public, true)
      end

      with(:tag_names, filters[:tags].split(","))
      with(:coll_names, filters[:collections].keys)
      
      if filters[:last_exported_begin] 
        with(:last_used).greater_than_or_equal_to(filters[:last_exported_begin])
      end

      if filters[:last_exported_end]
        with(:last_used).less_than_or_equal_to(filters[:last_exported_end])
      end

      fulltext filters[:search]
    end

    return problems.results
  end
end
