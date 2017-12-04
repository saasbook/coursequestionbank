class RuqlReader
  @file_processed = false
  def self.store_as_json(user_id, filename)
    user = Instructor.find_by_id(user_id)
    user.update_attributes(:uploaded_duplicates => false, :uploaded_same_file => false, :uploaded_empty_file => false, :current_collection => 0)
    Quiz.reset
    Quiz.instance_eval "#{IO.read(filename)}"
    collections = []
    dups_found = false
    Quiz.quizzes.uniq.each do |quiz|
      problems_json = quiz.render_with("JSON", {})
      collection = if (user.collections.find_by_name(quiz.title) and user.collections.find_by_name(quiz.title).instructor == user) then false else user.collections.new(:name => quiz.title) end
      if collection
        problems_json.each do |problem_json|
          problem = Problem.from_JSON(user, problem_json)
          problem.collections << collection
          problem.save
          Problem.reindex
          Sunspot.commit
          result = Problem.handle_dups(user, problem.id) #check for dups
          if result
            user.update_attributes(:uploaded_duplicates => true)
          end
        end
        collection.save!
        collections.append collection
      else
        user.update_attributes(:uploaded_same_file => true)
      end
    end
    id = collections.map{|collection| collection.id}
    user.update_attributes(:current_collection => id[0])
    if collections.nil? or collections.empty?
      user.update_attributes(:uploaded_empty_file => true)
    end
  end

  def self.read_problem(user, source)
    quiz = Quiz.new(nil)
    quiz.instance_eval(source)
    problems_json = quiz.render_with("JSON", {})
    raise 'Question source must contain exactly one question.' unless problems_json.size == 1
    Problem.from_JSON(user, problems_json[0])
  end
  def self.notify_file_processed
    @file_processed = true
  end
end
