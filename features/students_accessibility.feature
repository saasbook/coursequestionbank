Feature: Student accessibility of the app
  As a Student, I should not see the admin panel and have no access to the panel whatsoever.
  I should not have access of my own collection, but I can see public collections.


  Background:
    Given I am signed in with uid "12345" and provider "developer"

  Scenario: student can be correctly identified
    When I am on the CourseQuestionBank home page
    Then I should see "Student!"
    And I should see "Public Collections"
    And I should not see "My Collections"


  Scenario: we can not see the admin panel as a student
  
    When I am on the CourseQuestionBank home page
    Then I should not see "Admin"

  Scenario: we can not access the admin panel

    When I am on the admin panel
    Then I should see "You don't have permission to access this page."
    And I am on the CourseQuestionBank home page

  Scenario: we can not access my collection

    When I am on the dashboard
    Then I should see "You don't have permission to access this page."
    And I am on the CourseQuestionBank home page

  # Scenario: we cannot search collections
    
  #   When I am 