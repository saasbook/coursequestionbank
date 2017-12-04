Feature: Instructor accessibility of the app
  As an Instructor, I should not see the admin panel and have no access to the panel whatsoever.
  I should have access of my own collection and public collections.


  Background:
    Given I am signed in with uid "123456" and provider "developer"

  Scenario: student can be correctly identified
    When I am on the CourseQuestionBank home page
    Then I should see "Instructor!"
    And I should see "Public Collections"
    And I should see "My Collections"


  Scenario: I can not see the admin panel as an Instructors
  
    When I am on the CourseQuestionBank home page
    Then I should not see "Admin"

  Scenario: I can not access the admin panel

    When I am on the admin panel
    Then I should see "You don't have permission to access this page."
    And I am on the CourseQuestionBank home page

  Scenario: I can access my collection by upload problems or create new collections

    When I am on the dashboard
    Then I should see "Upload questions"
    And I should see "New collection"  


  Scenario: I can change privacy of a collection
    Given I have uploaded 'bloom_test.txt'
    And I am on the CourseQuestionBank home page
    And I should see "Public"
    And I press "Public"
    Then I should be on the CourseQuestionBank home page
    And I press "Share"
    Then I should be on the CourseQuestionBank home page
    And I press "Private"
    Then I should be on the CourseQuestionBank home page
    
