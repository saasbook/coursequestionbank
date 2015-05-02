Feature: Administrator panel for authorizing users
  As a CourseQuestionBank Administrator
  I want to be able to approve and add instructors to my site
  So that only approved users can use CourseQuestionBank

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard

  Scenario: visit the admin panel and authorize a user
    When I am on the admin panel
    Then I should see "Your current permission level is admin"
    When I fill in "username" with "RAILSDOESNTSCALE" 
    And I press "Add"
    Then I should see "Successfully added user" 
