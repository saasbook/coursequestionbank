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
    text.scan(/(select_multiple .*end)/m).each {|m| puts m}
    puts "TOTAL ELEMENTS FOUND #{a}"
    # /select_multiple .*end/m.scan(text)
    puts 'TOTAL TIME', Time.now - start, '------------------------------------'
    true
  end
end
