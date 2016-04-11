Feature: User can add tags to questions at the time of import
  As an instructor,
  So that I can find questions easily in the future,
  I want to add tags to questions when I import them

  Scenario: add a new tag to the currently imported questions
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I follow "My Collections"
    And I follow "1/22/15 (W1 L2)"
    And I check problem containing "Around 2007, the claim"
    And I check problem containing "statements comparing Plan-and-Document"
    And I fill in "tag 1, tag 2" with "lorem, ipsum"
    And I press "Tag checked problems"
    Then I should see "lorem"
    And I should see "ipsum"
