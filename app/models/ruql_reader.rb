class RuqlReader
  def self.store_as_json(user, file)
    filename = file.path
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
          dups_found = true if result
        end
        collection.save!
        collections.append collection
      else
        raise 'Quiz with that name already exists in your list of collections. You probably didn\'t mean to upload the same quiz again. Try deleting the old collection and upload again if you really meant to do that.'
      end
    end
    [collections, dups_found]
  end

  def self.read_problem(user, source)
    quiz = Quiz.new(nil)
    quiz.instance_eval(source)
    problems_json = quiz.render_with("JSON", {})
    raise 'Question source must contain exactly one question.' unless problems_json.size == 1
    Problem.from_JSON(user, problems_json[0])
  end
end
