require 'ruql_renderer'

class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :rendered_text, :text, :json, :problem_type, :obsolete, :bloom_category, :uid
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  belongs_to :previous_version, class_name: 'Problem'
  validates :uid, uniqueness: true

  scope :is_public, -> { where(is_public:  true) }
  scope :last_used, ->(t) { where(last_used: t) }
  scope :instructor_id, ->(id) { where(instructor_id: id) }


  searchable do
    integer   :id
    text      :text
    text      :json, :more_like_this => true
    integer   :instructor_id
    boolean   :is_public
    time      :last_used
    time      :updated_at
    string    :problem_type
    time      :created_date
    boolean   :obsolete
    string    :bloom_category
    string    :uid

    string    :tag_names, :multiple => true do
      tags.map(&:name)
    end
    integer   :collection_ids, :multiple => true do
      collections.map(&:id)
    end
  end

  def self.all_problem_types
    {'Dropdown' => 'Dropdown', 'FillIn' => 'Fill-in',
      'MultipleChoice' => 'Multiple choice', 'SelectMultiple' => 'Select multiple',
      'TrueFalse' => 'True/False'}
  end

  def self.all_bloom_categories
    %w{Remember Understand Apply Evaluate}
  end

  def self.sort_by_options
    ['Relevancy', 'Date Created', 'Last Used']
  end

  def html5
    if rendered_text
      return rendered_text
    end

    if json and !json.empty?
      begin
        question = Question.from_JSON(self.json)
        quiz = Quiz.new("", nil, :questions => [question])
        quiz.render_with("Html5", {'template' => 'preview.html.erb'})
        self.update_attributes(:rendered_text => quiz.output)
        quiz.output
      rescue
        return 'There was a problem rendering this question'
      end
    else
      'This question could not be displayed (no JSON found)'
    end
  end

  def ruql_source
    new_uid = SecureRandom.uuid
    prev_uid = self.uid
    return RuqlRenderer.render_from_json(self.json, new_uid, prev_uid)
  end

  def self.from_JSON(instructor, json_source)
    return "" if json_source == nil || json_source.length <= 2
    json_hash = JSON.parse(json_source)
    problem = Problem.new(text: "",
                          json: json_source,
                          is_public: true,
                          problem_type: json_hash["question_type"],
                          created_date: Time.now,
                          uid: json_hash["uid"].equal?(-1) ? SecureRandom.uuid : json_hash["uid"])
    problem.instructor = instructor
    json_hash["question_tags"].each do |tag_name|
      tag = Tag.find_by_name(tag_name) || Tag.create(name: tag_name)
      problem.tags << tag
    end
    problem
  end

  def self.filter(user, filters, bump_problem)
    problems = Problem.search do
      any_of do
        with(:instructor_id, user.id)
        with(:is_public, true)
      end

      filters[:tags].each do |tag|
        with(:tag_names, tag)
      end

      if !filters[:problem_type].empty?
        any_of do
          filters[:problem_type].each do |sort_param|
            with(:problem_type, sort_param)
          end
        end
      end

      if !filters[:bloom_category].empty?
        any_of do
          filters[:bloom_category].each do |category|
            with(:bloom_category, category)
          end
        end
      end

      if !filters[:collections].empty?
        any_of do
          filters[:collections].each do |col|
            with(:collection_ids, col)
          end
        end
      end

      if !filters[:show_obsolete]
        without(:obsolete, true)
      end

      fulltext filters[:search]

      if filters[:sort_by] == 'Relevancy'
        order_by(:score, :desc)
      elsif filters[:sort_by] == 'Date Created'
        order_by(:created_date, :desc)
      elsif filters[:sort_by] == 'Last Used'
        order_by(:last_used, :desc)
      end

      paginate :page => filters['page'], :per_page => filters['per_page']
    end

    results = problems.results
    if !bump_problem.nil?
      results.reject! {|p| p.id == bump_problem.id}
      results.insert(0, bump_problem)
    end
    return results
  end

  # def supersede(user, source)
  #   new_problem = RuqlReader.read_problem(user, source)
  #   new_problem.previous_version = self
  #   new_problem.is_public = self.is_public
  #   new_problem.tags += tags
  #   new_problem.save
  #   new_problem
  # end

  def add_tag(tag_name)
    return false if tag_name.strip == ""
    return false if tags.find_by_name(tag_name)

    tags << (Tag.where(name: tag_name)[0] || Tag.create(name: tag_name))
    save
    return true
  end

  def remove_tag(tag_name)
    tag = tags.find_by_name(tag_name)
    tags.delete(tag) if tag
    save
  end

  def add_tags(tag_names)
    tag_names.select{ |tag| add_tag tag }.map{ |tag| Tag.where(:name => tag)[0] }
  end

  def history(max = 10)
    return [] if previous_version == nil or max == 0
    return [previous_version] + previous_version.history(max - 1)
  end

  def self.handle_dups(user, problem_id)
    near_dups = Problem.near_dups_of(user, problem_id)
    to_tag = (near_dups + Problem.exact_title_match(user, problem_id)).uniq
    problem_uid = Problem.find(problem_id).uid #CHANGE THIS TO UID WHEN MIGRATION COMPLETE
    to_tag.delete(Problem.find(problem_id))
    if !to_tag.empty?
      tag_dups(problem_id, problem_uid) #tag original with its own uid
      to_tag.each { |id|  tag_dups(id, problem_uid)}
      return true # true for dups_found
    end
  end

  def self.tag_dups(id, original_uid)
    # tag all dups with the uid of the original and "dup"
    problem = Problem.find(id)
    tags = ["dup", original_uid.to_s]
    problem.add_tags(tags)
  end

  def self.exact_title_match(current_user, problem_id)
    target = Problem.find(problem_id)
    target_json = JSON.parse(target.json)

    from_you = current_user.problems
    from_others = Problem.where(is_public: true)
    search_set = (from_you + from_others).uniq
    results = []
    search_set.each do |other|
      other_json = JSON.parse(other.json)
      if target_json["question_text"] == other_json["question_text"]
        results.push(other)
      end
    end
    return results
  end

  def self.near_dups_of(current_user, problem_id)
    target = Problem.find(problem_id)
    user_id = current_user.id
    similar_probs = Sunspot.more_like_this(target) do
      fields :json # Also limited by stopwords.txt
      any_of do
        with(:instructor_id, user_id)
        with(:is_public, true)
      end
      minimum_term_frequency 1
      minimum_document_frequency 1
      minimum_word_length 5
      maximum_word_length 12
    end

    results = []
    match = similar_probs.results[0]
    results.push(match) if match
    return results
  end

end
