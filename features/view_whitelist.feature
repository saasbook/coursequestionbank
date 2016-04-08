Feature: Admin can view a list of allowed Users on the app's whitelist
  As an admin
  So that I can manage access to the app
  I want to see the current whitelist settings

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I am on the admin panel

Scenario: Admin sees a list of whitelisted users
  When I fill in "username" with "NEWADMIN"
  And I press "Add"
  Then I should see "Successfully added user"
  And I should see "NEWADMIN"

Scenario: Admin sees an empty whitelist (sad path)
  When I am on the admin panel
  Then I should see "No other users on the whitelist."
  Then I should not see "NEWADMIN"
