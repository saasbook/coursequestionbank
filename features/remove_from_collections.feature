Feature: User can remove individual problems from a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to remove a problem from a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt' 
  And I am on the CourseQuestionBank home page

Scenario: Remove a problem from collection
  When I am on the dashboard
  And I follow "New collection"
  And I fill in "name" with "test1"
  And I press "Create"
  And I am on the dashboard
  And I should see Collection 'test1' in the database
  
  When I am on the dashboard
  And I should see "test1"
  Then I follow "test1"
  And I should see "Edit this collection"

  When I follow "Edit this collection"
  Then I press "delete_collection_button"
  Then I should see "Collection deleted"