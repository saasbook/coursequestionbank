require 'ruql'
require 'json'

class RuqlReader < ActiveRecord::Base
  # attr_accessible :title, :body
  @@question_types = [:select_multiple, :choice_answer, :fill_in]
  def self.read_ruql(file)
    # quiz_name = nil
    # current_collection = nil
    # current_tag = nil
    # file.open.each do |line|
    #   /quiz\s+'(.*)'\s+do/.match(line) do |capture| 
    #     quiz_name = capture[1]}
    #     current_collection = Collection.create(:name => quiz_name)
    #     current_tag = Tag.create(:name => quiz_name)
    #   end

    #   question_types.each do |question_type|
    #     if line.include? question_type.to_s
    #       problem = Problem.create()

    # end
    text = file.open.read
    start = Time.now
    a = 0
    text.scan(/select_multiple .*end/m).each {|m| a += 1 }
    puts "TOTAL ELEMENTS FOUND #{a}"
    # /select_multiple .*end/m.scan(text)
    puts 'TOTAL TIME', Time.now - start, '------------------------------------'
    true
  end


  def self.store_as_json(user, file)
    filename = file.path
    Quiz.instance_eval "#{IO.read(filename)}"
    Quiz.quizzes.each do |quiz| 
        problems_json = quiz.render_with("JSON", {})
        collection = Collection.find_by_name(quiz.title) || user.collections.create(:name => quiz.title)
        tag = Tag.find_by_name(quiz.title) || Tag.create(:name => quiz.title)
        problems_json.each do |problem_json| 
            #puts "blah blah blah ", problem_json
            #todo: parse json and get question_tags and question_type
            problem = Problem.new(text: "", json: problem_json, is_public: false)
            problem.instructor = user
            problem.collections << collection
            problem.tags << tag #TODO: fix so that questions still displayed if no tag assigned
            problem.save
            puts "yeah yeah yeah ", problem.json
        end
    end
  end
end
