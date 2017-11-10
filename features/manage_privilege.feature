Feature: Admin can view a list of users and update their privilege
  As an admin
  So that I can manage access to the app
  I want to see the current list of users

Background:
  Given I am signed in with uid "1234" and provider "github"
  Given there exist a user with username "stevenwuyinze" and uid "12345"
  And I am on the admin panel

Scenario: Admin can't change his own privilege
  When I select "Student" from "privilege_1234"
  And I press "update_1234"
  Then I should be on the admin panel
  Then I should see "Can't change your own privilege level"
  
Scenario: Admin can change users privilege
  Then I should see "stevenwuyinze"
  And I select "Instructor" from "privilege_12345"
  And I press "update_12345"
  Then I should be on the admin panel
  Then I should see "stevenwuyinze is now Instructor"