Given(/^I add tag "([^\"]*)" to problem "([^\"]*)"$/) do |tag, problem_id|
  Problem.find(problem_id).add_tag(tag)
end

Given(/^I remove tag "([^\"]*)" from problem "([^\"]*)"$/) do |tag_id, problem_id|
  Problem.find(problem_id).remove_tag(tag_id)
end