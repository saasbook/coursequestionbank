Feature: Administrator panel for authorizing users
  As a CourseQuestionBank Administrator
  I want to be able to approve and add instructors to my site
  So that only approved users can use CourseQuestionBank

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard

  Scenario: visit the admin panel and add a user
    When I am on the admin panel
    When I fill in "new-username" with "RAILSDOESNTSCALE"
    And I select "github" from "new-provider"
    And I select "instructor" from "new-privilege"
    And I press "new-submit"
    Then I should see "Whitelist updated"