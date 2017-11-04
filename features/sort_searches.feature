#Feature: User can view search results with a priority on closest matches
#  As an instructor,
#  So that I can view the most relevant and useful questions,
#  I want to sort my search results by certain metrics
#
#Background:
#  Given I am signed in with uid "1234" and provider "github"
#  Given I am on the CourseQuestionBank home page
#
#  Given the following problems exist:
#  | text         | last_used                              | problem_type   | created_date                              | uid   |
#  | text1        | datetime.now                           | FillIn         | datetime.now                              | 1g3j2 |
#  | text2        | datetime.now+datetime.timedelta(day=1) | MultipleChoice | datetime.now                              | 5hfnn |
#  | text3        | datetime.now+datetime.timedelta(day=2) | SelectMultiple | datetime.now                              | 2h51h |
#  | text4        | datetime.now+datetime.timedelta(day=3) | TrueFalse      | datetime.now + datetime.timedelta(day=30) | 4h11k |
#  | text5        | datetime.now+datetime.timedelta(day=4) | Dropdown       | datetime.now                              | th2kv |
#
##Scenario: sort search results by date added
# # When I check "date_added_checkbox"
#  #Then I should see "text1" before "text4"
#
##Scenario: sort by level of difficulty
#
#Scenario: sort by last used
#  When I choose sort by "Last Used"
#  And I press "Search"
#  Then I should see "text1" before "text5"
#
#Scenario: sort by problem type: true/false
#  When I check "True/False"
#  And I press "Search"
#  Then I should see "text4"
#  And I should not see "text1"
#  And I should not see "text2"
#  And I should not see "text3"
#  And I should not see "text5"
#
#Scenario: sort by problem type: fill_in
#  When I check "Fill-in"
#  And I press "Search"
#  Then I should see "text1"
#  And I should not see "text2"
#  And I should not see "text3"
#  And I should not see "text4"
#  And I should not see "text5"
#
#Scenario: sort by problem type: choice_answer
#  When I check "Multiple choice"
#  And I press "Search"
#  Then I should see "text2"
#  And I should not see "text1"
#  And I should not see "text3"
#  And I should not see "text4"
#  And I should not see "text5"
#
#Scenario: sort by problem type: select_multiple
#  When I check "Select multiple"
#  And I press "Search"
#  Then I should see "text3"
#  And I should not see "text1"
#  And I should not see "text2"
#  And I should not see "text4"
#  And I should not see "text5"
#
#Scenario: sort by problem type: dropdown
#  When I check "Dropdown"
#  And I press "Search"
#  Then I should see "text5"
#  And I should not see "text1"
#  And I should not see "text2"
#  And I should not see "text4"
#  And I should not see "text3"
#
#Scenario: search returns no results
#    And I am on the CourseQuestionBank home page
#    When I fill in "Search Keywords" with "nonexistent"
#    And I press "Search"
#    Then I should see "No questions matched your search criteria"
