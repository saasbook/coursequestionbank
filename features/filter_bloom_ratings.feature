Feature: User can filter search results by Bloom Taxonomy rating
  As an instructor,
  So that I can sort questions by teaching objective,
  I want to filter search results by Bloom ratings

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page

Scenario: positive filtering by Bloom rating
  When I press "Understand"
  And I check "Understand"
  And I press "Search"
  Then I should see "Which of the following"

Scenario: negative filtering by Bloom rating
  When I press "Understand"
  And I check "Evaluate"
  And I press "Search"
  Then I should see "No questions matched your search criteria"

Scenario: filtering by multiple ratings
  When I press "Evaluate"
  And I check "Understand"
  And I check "Evaluate"
  And I press "Search"
  Then I should see "Which of the following"
  And I should not see "No questions matched your search criteria"

Scenario: no matching results for Bloom Taxonomy rating
  When I check "Remember"
  And I press "Search"
  Then I should see "No questions matched your search criteria"
