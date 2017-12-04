
class RuqlRenderer
  def initialize(json_code, uid = "", prev_uid = "")
    if json_code == nil || json_code.length <= 2
      raise Exception("The question seems to be empty.")
    end
    @level = 0
    @result = ""
    @uid = uid
    @prev_uid = prev_uid
    @json_hash = JSON.parse(json_code)
  end

  def self.render_from_json(json, new_uid, prev_uid)
    renderer = RuqlRenderer.new(json, new_uid, prev_uid)
    renderer.rendered
  end

  def rendered
    render_questions(@json_hash, @uid, @prev_uid)
    @result
  end

  def write_line(text, cond = true)
    if text.to_s != "" && cond
      @result << (["  "] * @level).join("")
      @result << text + "\n"
    end
  end

  def render_questions(json_hash, uid = "", prev_uid = "")
    if json_hash["question_type"] == "TrueFalse"
      render_true_false(json_hash)
      return
    end
    render_question_header(json_hash)
    @level += 1
    write_line("uid #{uid.inspect}", uid.to_s != "")
    write_line("#uid #{prev_uid.inspect}", prev_uid.to_s != "")
    write_line("image " + json_hash["question_image"].inspect, json_hash["question_image"] != nil)
    write_line("explanation " + json_hash["global_explanation"].inspect, json_hash["global_explanation"] != nil)
    write_line("text " + json_hash["question_text"].inspect)
    render_answers(json_hash)
    @level -= 1
    write_line("end")
  end

  def render_question_header(json_hash)
    type = case @json_hash["question_type"]
               when "SelectMultiple" then "select_multiple"
               when "MultipleChoice" then "choice_answer"
               when "FillIn" then "fill_in"
               when "Group" then "grouped_question" else ""
           end
    options = ['randomize', 'raw'].select{|x| json_hash[x]}.map{|x| ":#{x} => true"}.join(', ')
    write_line([type, options, "do"].join(' '))
  end

  def render_answers(json_hash)
    if json_hash["question_type"] == "Group"
      json_hash["questions"].each do |sub_question|
        render_questions(sub_question)
      end
    else
      json_hash["answers"].each do |answer|
        render_answer_line(answer)
      end
    end
  end

  def render_true_false(json_hash)
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
    write_line(line)
  end

  def render_answer_line(answer)
    type = answer["correct"] ? "answer" : "distractor"
    body = answer["answer_text"].inspect
    if answer["explanation"]
      body += ', :explanation => ' + answer["explanation"].inspect
    end
    write_line([type, body].join(" "))
  end
end
