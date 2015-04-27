class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name, :description, :is_public
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :problems
  belongs_to :instructor
  # scope :collection, ->(collection_name) { where(name: collection_name) }
  scope :mine_or_public, ->(user) {where('instructor_id=? OR is_public=?', "#{user.id}", 'true')}

  def add_to_collection(problem)
    if problems.include? problem
      return false
    else 
      update_attributes(problem)
    end
  end

  def export(format)
    if problems.empty? 
      return nil
    else 
      export_quiz = Quiz.new(name, {:questions => problems.map {|problem| Question.from_JSON(problem.json)}})
      export_quiz.render_with(format)
    end
  end

  def public?
    self.is_public
  end
end
