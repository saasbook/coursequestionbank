class Problem < ActiveRecord::Base
  attr_accessible :created_date, :is_public, :last_used, :rendered_text, :text, :json, :problem_type, :bloom_category
  has_and_belongs_to_many :tags
  belongs_to :instructor
  has_and_belongs_to_many :collections
  belongs_to :previous_version, class_name: 'Problem'


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
    string    :problem_type
    time      :created_date
    string    :bloom_category

    string    :tag_names, :multiple => true do
      tags.map(&:name)
    end
    integer :collection_ids, :multiple => true do
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
      question = Question.from_JSON(self.json)
      quiz = Quiz.new("", :questions => [question])
      quiz.render_with("Html5", {'template' => 'preview.html.erb'})
      self.update_attributes(:rendered_text => quiz.output)
      quiz.output
    else
      'This question could not be displayed (no JSON found)'
    end
  end

  def ruql_source
    result = ""
    return "" if self.json == nil || self.json.length <= 2
    json_hash = JSON.parse(self.json)
    answers = json_hash["answers"]
    return ruql_true_false(json_hash) if json_hash["question_type"] == "TrueFalse"
    result << ruql_question_header(json_hash)
    result << "\n  text " + json_hash["question_text"].inspect
    answers.each do |answer| # answers first
      result << ruql_answer_line(answer) if answer["correct"]
    end
    answers.each do |answer| # distractors second
      result << ruql_answer_line(answer) if !answer["correct"]
    end
    result << "\nend"
    return result
  end

  def ruql_true_false(json_hash)
    line = "truefalse "
    line += json_hash["question_text"].inspect
    json_hash["answers"].each do |answer|
      if answer["correct"]
        line += answer["answer_text"].inspect
      end
      if answer["explanation"]
        line += ', :explanation => ' + answer["explanation"].inspect
      end
    end
    return line
  end

  def ruql_question_header(json_hash)
    line = case json_hash["question_type"]
      when "SelectMultiple" then "select_multiple"
      when "MultipleChoice" then "choice_answer"
      when "FillIn" then "fill_in"
      else ""
    end
    if json_hash["randomize"]
      line += ' :randomize => true'
    end
    return line + " do"
  end

  def ruql_answer_line(answer)
    line = "\n  "
    line += answer["correct"] ? "answer" : "distractor"
    line += ' ' + answer["answer_text"].inspect
    if answer["explanation"]
      line += ', :explanation => ' + answer["explanation"].inspect
    end
    return line
  end

  def self.from_JSON(instructor, json_source)
    return "" if json_source == nil || json_source.length <= 2
    json_hash = JSON.parse(json_source)
    problem = Problem.new(text: "",
                          json: json_source,
                          is_public: false,
                          problem_type: json_hash["question_type"],
                          created_date: Time.now)
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

  def supersede(user, source)
    new_problem = RuqlReader.read_problem(user, source)
    new_problem.previous_version = self
    new_problem.is_public = self.is_public
    new_problem.save
    new_problem
  end

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

  def bloom_categorize(category)
    self.bloom_category = category
    save
  end
  
  def history
    return [] if previous_version == nil
    return [previous_version] + previous_version.history
  end
end
