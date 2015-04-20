class RuqlReader
  def self.store_as_json(user, file)
    filename = file.path
    Quiz.nuke_from_orbit
    Quiz.instance_eval "#{IO.read(filename)}"
    collections = []
    puts Quiz.quizzes.map{|q| q.title + ' ,'}.join
    puts Quiz.quizzes.uniq.map{|q| q.title + ' ,'}.join
    Quiz.quizzes.uniq.each do |quiz|
      problems_json = quiz.render_with("JSON", {})
      collection = if Collection.find_by_name(quiz.title) then false else user.collections.create(:name => quiz.title) end
      if collection
        collections.append collection
        problems_json.each do |problem_json|
          json_hash = JSON.parse(problem_json)
          problem = Problem.new(text: "", 
                                json: problem_json,
                                is_public: false, 
                                problem_type: json_hash["question_type"], 
                                created_date: Time.now)
          problem.instructor = user
          problem.collections << collection
          json_hash["question_tags"].each do |tag_name|
            tag = Tag.find_by_name(tag_name) || Tag.create(name: tag_name)
            problem.tags << tag
          end
          problem.save
        end
      else
        raise 'Quiz with that name already exists in your list of collections. You probably didn\'t mean to upload the same quiz again. Try deleting the old collection and upload again if you really meant to do that '
      end
    end
    collections
  end
end
