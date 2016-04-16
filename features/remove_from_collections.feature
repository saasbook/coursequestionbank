Feature: User can remove individual problems from a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to remove a problem from a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt' 
  And I am on the CourseQuestionBank home page

Scenario: Remove a problem from collection
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem removed from 1/22/15 (W1 L2)"
  When I follow "My Collections"
  When I follow "1/22/15 (W1 L2)"
  Then I should not see "Around 2007, the claim"