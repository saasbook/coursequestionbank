class RuqlReader < ActiveRecord::Base

  def self.store_as_json(user, file)
    filename = file.path
    Quiz.instance_eval "#{IO.read(filename)}"
    Quiz.quizzes.each do |quiz| 
        problems_json = quiz.render_with("JSON", {})
        collection = Collection.find_by_name(quiz.title) || user.collections.create(:name => quiz.title)
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
    end
  end
end
