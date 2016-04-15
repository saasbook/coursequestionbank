Feature: Admin can enable or disable a whitelist for access to the app
  As an admin
  So that I can control who can see public questions
  I want to manage who can log in to the app

Background:
  Given I am signed in with uid "1234" and provider "github"

Scenario: Admin enables whitelist restrictions
  Given the whitelist is disabled
  And I am on the admin page
  And I press "Enable whitelist"
  Then I should see "Whitelist enabled"
  Given I am signed in with uid "4321" and provider "github"
  And I am on the problems page
  Then I should be on the login page

Scenario: Admin disables whitelist restrictions
  Given the whitelist is enabled
  And I am on the admin page
  And I press "Disable whitelist"
  Then I should see "Whitelist disabled"
  Given I am signed in with uid "4321" and provider "github"
  And I am on the problems page
  Then I should be on the problems page
