Feature: User can add individual problems to a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to add a problem to a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'
  And I am on the CourseQuestionBank home page

Scenario: Remove a problem to collection
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem removed from 1/22/15 (W1 L2)"

Scenario: Add problem to a collection
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem removed from 1/22/15 (W1 L2)"
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem added to 1/22/15 (W1 L2)"
