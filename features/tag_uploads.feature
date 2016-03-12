Feature: User can add tags to questions at the time of import
  As an instructor,
  So that I can find questions easily in the future,
  I want to add tags to questions when I import them

Scenario: add an existing tag to the currently imported questions
  Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    Then I should see "Your quiz was successfully uploaded!"
    Then I should see "Review them below:"
    And I add tag "tag1" 
    And I check problem "1"
    And I check problem "2"
    When I press submit 

Scenario: add a new tag to the currently imported questions
