class Collection < ActiveRecord::Base
  attr_accessible :last_used, :name, :description, :is_public, :color
  validates :name, presence: true #, uniqueness: true for now this is bad
  has_and_belongs_to_many :problems
  belongs_to :instructor
  # scope :collection, ->(collection_name) { where(name: collection_name) }
  scope :mine_or_public, ->(user) {where('instructor_id=? OR is_public=?', "#{user.id}", 'true')}
  scope :public, where(:is_public => true)

  def set_attributes(params)
    self.name = params[:name] if params[:name]
    self.description = params[:description] if params[:description]
    self.is_public = params[:is_public] if params[:is_public]
    if ['Public', 'Private'].include? params[:privacy]
      self.is_public = params[:privacy] == 'Public'
    end
  end

  def export(format)
    if problems.empty? 
      return nil
    else 
      if format == 'ruql'
        print_name = (description.nil? || description.strip.empty?) ? name : name + ': ' + description
        source = "quiz #{print_name.inspect} do\n"
        problems.each do |prob|
          prob_source = prob.ruql_source.lines.map{|x| '  ' + x}.join
          source += "\n#{prob_source}\n"
        end
        source += "\nend"
      else
        export_quiz = Quiz.new(name, nil, {:questions => problems.map {|problem| Question.from_JSON(problem.json)}})
        export_quiz.render_with(format)
      end
    end
  end

  def public?
    self.is_public
  end
end
