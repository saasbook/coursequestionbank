Feature: I am able to preview the ruql format in preview quiz
  Background:
    Given I am on the login page
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'bloom_test.txt'


  Scenario: I can export and view the content
    Given I am on the collection index page
    Given I am on the collection edit page
    Then I am on the export page
    Then I should see "Preview"
    Then I follow "Preview quiz"
    And I should see "Which of the following best identifies the four basic operations supported by RDBMS?"
    And I should not see "Previous version:"
    And I should not see "Your Collections:"
    And I should not see "Bloom Category:"
    And I should not see "Supersede:"
