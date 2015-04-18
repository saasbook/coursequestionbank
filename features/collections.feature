Feature: collections that we can add problems to
  As an instructor
  So that I can group problems together and export 
  I want to be able to add problems to a collection

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the dashboard
  
  Scenario: create a new collection
    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create Collection"
    Then I should be on the dashboard
    And I should see Collection 'yolo' in the database

  Scenario: add a new question to current collection
    When I create a new collection 'yolo' and mark it as current
    Then I add the problem containing text 'Raffi' to the current collection
    Then I should see 'Raffi' within the collection 'yolo'

  Scenario: use the dropdown to add a question to non-current collection:
    When I create a new collection 'yolo'
    Then I add the problem containing text 'Raffi' to 'yolo'


    