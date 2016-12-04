Feature: Administrator panel for authorizing users
  As a CourseQuestionBank Administrator
  I want to be able to approve and add instructors to my site
  So that only approved users can use CourseQuestionBank

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard

  Scenario: We can not add new users from panel since the features changed

    When I am on the admin panel
    Then I should not see "new-provider"
    And I should not see "new-privilege"
    And I should not see "new-submit"
    And I should see "stevenwuyinze"
    And I should see "Student"

  Scenario: I should see the users with different privilage
      When I am on the admin panel
      Then I should see "stevenwuyinze"
      Then I should see "Student"
      Then I should see "Another-UGSI"
      Then I should see "Instructor"

  Scenario: As an admin, I should be able to change the privilage for different users
      When I am on the admin panel
      Then I should see a button "Update"
