Given(/^I add tag "([^\"]*)" to problem "([^\"]*)"$/) do |tag, problem_id|
  visit "add/" + tag + "/to/problem/" + problem_id
end

Given(/^I remove tag "([^\"]*)" from problem "([^\"]*)"$/) do |tag_id, problem_id|
  visit "remove/" + tag_id + "/from/problem/" + problem_id
end