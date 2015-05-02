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
    And I press "Create"
    Then I should be on the dashboard
    And I add problem containing 'Raffi' to collection 'yolo'
    And I should see Collection 'yolo' in the database
 
  Scenario: create a new collection
    When I follow "start a new collection"
    And I fill in "collection_name" with ""
    And I press "Create"
    Then I should see "can't be blank"
    

  Scenario: remove a problem
    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create"
    Then I should be on the dashboard
    And I add problem containing 'Rails' to collection 'yolo'
    And I should see Collection 'yolo' in the database
    And I remove problem containing 'Rails' to collection 'yolo'
    Then I should not see 'Rails' in collection 'yolo'

  Scenario: update a collection name
    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create"
    And I update 'yolo' to 'swag'
    Then I should see Collection 'swag' in the database

  Scenario: attempt to update a collection with invalid name
    When I follow "start a new collection"
    And I fill in "collection_name" with "yolo"
    And I press "Create"
    And I update 'yolo' to ''
    Then I should see Collection 'yolo' in the database

  Scenario: delete a collection
    When I create a new collection 'apple' and mark it as current
    Given I am looking at edit page regarding collection 'apple'
    When I press the trash icon at 'apple'
    Then I should be on the dashboard
    And I should not see Collection 'apple' in the database
