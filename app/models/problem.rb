class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :rendered_text, :text, :json, :problem_type
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections


  scope :is_public, -> { where(is_public:  true) }
  scope :last_used, ->(t) { where(last_used: t) }
  scope :instructor_id, ->(id) { where(instructor_id: id) }


  searchable do
    integer   :id
    text      :text
    text      :json
    integer   :instructor_id
    boolean   :is_public
    time      :last_used
    time      :updated_at
    # integer :collection_id

    string    :tag_names, :multiple => true do
      tags.map(&:name)
    end
    integer :collection_ids, :multiple => true do
      collections.map(&:id)
    end
  end

  def html5
    if rendered_text
      return rendered_text
    end

    if json and !json.empty?
      question = Question.from_JSON(self.json)
      quiz = Quiz.new("", :questions => [question])
      quiz.render_with("Html5", {'template' => 'preview.html.erb'})
      self.update_attributes(:rendered_text => quiz.output)
      quiz.output
    else
      'This question could not be displayed (no JSON found)'
    end
  end

  def self.filter(user, filters)
    problems = Problem.search do
      any_of do
        with(:instructor_id, user.id)
        with(:is_public, true)
      end

      filters[:tags].each do |tag|
        with(:tag_names, tag)
      end

      if !filters[:collections].empty?
        any_of do
          filters[:collections].each do |col|
            with(:collection_ids, col)
          end
        end
      end

      # if filters['last_exported_begin']
      #   with(:last_used).greater_than_or_equal_to(filters[:last_exported_begin])
      # end
      # if filters['last_exported_end']
      #   with(:last_used).less_than_or_equal_to(filters[:last_exported_end])
      # end

      fulltext filters[:search]
      order_by(:updated_at, :desc)
      paginate :page => filters['page'], :per_page => filters['per_page']
    end

    problems.results
  end
  
  def add_tag(tag_name)
    tag = tags.find_by_name(tag_name)
    if !tag
      matched = Tag.where(name: tag_name)
      if matched.size == 0
        tag = Tag.create(name: tag_name)
      else
        tag = matched[0]
      end
      tags << tag
      save
    end
    tag
  end
  
  def add_tags(tag_names)
    count = tags.size
    tag_names.each { |tag| add_tag tag }
    return tags.size > count
  end
end
