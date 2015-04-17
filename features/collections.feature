Feature: collections that we can add problems to
  As an instructor
  So that I can group problems together and export 
  I want to be able to add problems to a collection

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard
    And I have uploaded 'test_quizzes'
  
  Scenario: create a new collection

    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create Collection"
    Then I should be on the dashboard
    And I should see collection 'yolo' in the database

  Scenario: add a new question
    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create Collection"
    Then I should be on the dashboard
    Then I am on the problems page

    