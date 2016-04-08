Feature: User can upload Ruql source code with a universal ID to identify questions
  As an instructor
  So that I can keep track of individual questions across systems
  I want to give each question a unique ID

Background:
  Given I am signed in with uid "1234" and provider "github"

Scenario: Uploading a question with a new universal ID
  Given I have uploaded 'new_universal_id.txt'
  And I am on the home page
  And I follow "View 60"
  When I follow "supersede_button" for problem containing "This problem had a provided universal ID."
  Then I should see "baa214b01b59a06a1c5c01a0d77bab38757193cb3a9dd07dfb86ad481cb900ea"

Scenario: Uploading a question with an existing universal ID gets rejected (sad path)
  Given I have uploaded 'new_universal_id.txt'
  And I have uploaded 'redundant_universal_id.txt'
  Then I should see "Problems with universal IDs already in the database have been rejected."
  And I am on the home page
  And I follow "View 60"
  Then I should not see "This question should have been rejected."
