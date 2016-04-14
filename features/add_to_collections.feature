Feature: User can add individual problems to a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to add a problem to a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'
  And I am on the CourseQuestionBank home page

Scenario: Add a problem to collection
  When I check problem containing "Around 2007, the claim"
  And I check "1/22/15 (W1 L2)"
  When I press "Add to Collection"
  Then I should see "Question added to collection"
  When I follow "1/22/15 (W1 L2)"
  Then I should see "Around 2007, the claim"

Scenario: Try to problem to collection twice (sad path)
  Given I have added problem containing "Around 2007, the claim" to "1/22/15 (W1 L2)"
  When I check problem containing "Around 2007, the claim"
  And I check "1/22/15 (W1 L2)"
  When I press "Add to Collection"
  Then I should see "Error: problem already in collection"

Scenario: No problem selected to add to collection (sad path)
  When I check "1/22/15 (W1 L2)"
  When I press "Add to Collection"
  Then I should see "Error: you need to select a problem"

Scenario: No collection selected (sad path)
  Given I have added problem containing "Around 2007, the claim" to "1/22/15 (W1 L2)"
  When I check problem containing "Around 2007, the claim"
  When I press "Add to Collection"
  Then I should see "Error: you need to select a collection"
