Feature: Admin can view a list of allowed Users on the app's whitelist
  As an admin
  So that I can manage access to the app
  I want to see the current whitelist settings

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I am on the admin panel

Scenario: Admin sees a list of whitelisted users
  When I fill in "new-username" with "new_admin"
  And I select "github" from "new-provider"
  And I select "admin" from "new-privilege"
  And I press "new-submit"
  Then I should see "Whitelist updated"
  And I should see "new_admin"

Scenario: Admin can't change his own privilege
  When I fill in "new-username" with "test"
  And I select "github" from "new-provider"
  And I select "instructor" from "new-privilege"
  And I press "new-submit"
  Then I should see "Can't change your own privilege level"
