Feature: User can view search results with a priority on closest matches
  As an instructor,
  So that I can view the most relevant and useful questions,
  I want to sort my search results by certain metrics

Background: 
  Given the following problems exist:
  | text         | last_used                              | problem_type    | release_date |
  | text1        | datetime.now                           | fill_in         | datetime.now |
  | text2        | datetime.now+datetime.timedelta(day=1) | choice_answer   | datetime.now |
  | text3        | datetime.now+datetime.timedelta(day=2) | select_multiple | datetime.now |
  | text4        | datetime.now+datetime.timedelta(day=3) | truefalse       | datetime.now |
  | text5        | datetime.now+datetime.timedelta(day=4) | dropdown        | datetime.now |

Scenario: filter by tags used
  Given I add tag "([^\"]*)" to problem "([^\"]*)"$/) do |tag, problem_id|
Scenario: sort search results by date added

#Scenario: sort by level of difficulty
Scenario: sort by last used

Scenario: search returns no results
  Given I search "nonexistent problem"
  Then I should see "No questions matched your search criteria"
