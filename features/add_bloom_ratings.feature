Feature: User can associate a Bloom Taxonomy rating with a question
  As an instructor,
  So that I can organize questions by teaching objective,
  I want to add a Bloom Taxonomy rating to questions

Background:
  Given I am signed in with uid "1234" and provider "github"
  Then I should see "Admin"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page

Scenario: giving newly uploaded questions Bloom Taxonomy ratings
  When I press "Remember"
  Then I should be on the problems page
  When I check "Remember"
  And I press "Search"
  Then I should not see "No questions matched your search criteria"
