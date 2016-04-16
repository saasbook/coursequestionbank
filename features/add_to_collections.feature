Feature: User can add individual problems to a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to add a problem to a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'
  And I am on the CourseQuestionBank home page

Scenario: Add problem to a different collection (belongs to two collections)
  When I toggle collection "1/29/15 (W2 L2): Ruby; HTTP/HTML/CSS basics" for problem containing "Around 2007, the claim"
  Then I should see "Problem added to 1/29/15 (W2 L2): Ruby; HTTP/HTML/CSS basics"
  When I follow "My Collections"
  When I follow "1/29/15 (W2 L2): Ruby; HTTP/HTML/CSS basics"
  Then I should see "Around 2007, the claim"
  
  When I follow "My Collections"
  When I follow "1/22/15 (W1 L2)"
  Then I should see "Around 2007, the claim"
  
  When I follow "My Collections"
  When I follow "3/7 version control"
  Then I should not see "Around 2007, the claim"

Scenario: Add problem to a collection after removing it
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem removed from 1/22/15 (W1 L2)"
  When I toggle collection "1/22/15 (W1 L2)" for problem containing "Around 2007, the claim"
  Then I should see "Problem added to 1/22/15 (W1 L2)"
  When I follow "My Collections"
  When I follow "1/29/15 (W2 L2): Ruby; HTTP/HTML/CSS basics"
  Then I should not see "Around 2007, the claim"
  When I follow "My Collections"
  When I follow "1/22/15 (W1 L2)"
  Then I should see "Around 2007, the claim"