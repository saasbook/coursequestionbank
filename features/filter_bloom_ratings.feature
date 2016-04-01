Feature: User can filter search results by Bloom Taxonomy rating
  As an instructor,
  So that I can sort questions by teaching objective,
  I want to filter search results by Bloom ratings

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'foo.txt'
  And I am on the CourseQuestionBank home page

Scenario: filtering by Bloom rating
  When I check "Understand"
  And I press "Apply"
  Then I should see "understand question"
  And I should not see "evaluate question"

Scenario: filtering by multiple ratings
  When I check "Understand"
  And I check "Evaluate"
  And I press "Apply"
  Then I should see "understand question"
  And I should see "evaluate question"
  And I should not see "analyze question"

Scenario: no matching results for Bloom Taxonomy rating
  When I check "Create"
  And I press "Apply"
  Then I should see "No results found"
