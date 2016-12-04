Feature: User can supersede a Question with new question source code
  As an instructor,
  So that I can replace a Question with a superseded version,
  I want to update a Question with new source code

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'history_test.txt'
  And I am on the CourseQuestionBank home page
  And I follow "View 60"

Scenario: replacing a question with a new version
  When I follow "supersede_button" for problem containing "Witch"
  And I fill in "ruql_source" with text of "history_test2.txt"
  And I press "Supersede question"
  And I am on the CourseQuestionBank home page
  And I should see "Witch"
  And I should see "Which of the following"

Scenario: syntax error in question supersession
  When I follow "supersede_button" for problem containing "Witch"
  And I fill in "ruql_source" with "Whoopsies :("
  And I press "Supersede question"
  Then I should see "unexpected '('"
