Feature: collections that we can add problems to
  As an instructor
  So that I can group problems together and export 
  I want to be able to add problems to a collection

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard
  
  Scenario: create a new collection
  	When I press "add_collection"
  	And I fill in "collection_name" with "yolo"
  	And I press "submit"
  	Then I should be on the dashboard




  



