Feature: Admin can enable or disable a whitelist for access to the app
  As an admin
  So that I can control who can see public questions
  I want to manage who can log in to the app

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I am on the admin page

Scenario: Admin enables whitelist restrictions
  When I am on the admin panel
  And I press "Enforce Whitelist"
  Then I should see "Whitelist is enforced. Only whitelisted users can log in."

Scenario: Admin disables whitelist restrictions
  When I am on the admin panel
  And I press "Disable Whitelist"
  Then I should see "Whitelist is disabled. Any public user can log in."
