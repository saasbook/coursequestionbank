Feature: User can see all the buttons associated with Bloom Taxonomy ratings
  As an instructor,
  So I can assign a learning objective rating to a question,
  I want to see all the Bloom Taxonomy rating buttons

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page

Scenario: listing Bloom rating buttons
  Then I should see a button "Remember"
  And I should see a button "Understand"
  And I should see a button "Apply"
  And I should see a button "Evaluate"
