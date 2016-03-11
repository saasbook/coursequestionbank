Feature: User can view search results with a priority on closest matches
  As an instructor,
  So that I can view the most relevant and useful questions,
  I want to sort my search results by certain metrics

Background: 
  Given I am on the CourseQuestionBank home page

  Given the following problems exist:
  | text         | last_used                              | problem_type    | created_date                              |
  | text1        | datetime.now                           | fill_in         | datetime.now                              |
  | text2        | datetime.now+datetime.timedelta(day=1) | choice_answer   | datetime.now                              |
  | text3        | datetime.now+datetime.timedelta(day=2) | select_multiple | datetime.now                              |
  | text4        | datetime.now+datetime.timedelta(day=3) | truefalse       | datetime.now + datetime.timedelta(day=30) |
  | text5        | datetime.now+datetime.timedelta(day=4) | dropdown        | datetime.now                              |
  
#Scenario: sort search results by date added
 # When I check "date_added_checkbox"
  #Then I should see "text1" before "text4"

#Scenario: sort by level of difficulty
  
Scenario: sort by last used
  When I check "last_used_checkbox"
  And I press "Apply"
  Then I should see "text1" before "text5"

Scenario: sort by problem type
  When I check "truefalse"
  And I press "Apply"
  Then I should see "text4"

Scenario: search returns no results
    When I fill in "Search Keywords" with "nonexistent"
    And I press "Apply"
    Then I should see "No questions matched your search criteria"
