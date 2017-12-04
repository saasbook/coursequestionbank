Feature: User can copy the source code of a Question to their local clipboard
  As an instructor,
  So that I can modify a question's source code locally in Ruql format,
  I want to copy the source code of a specific Question

Scenario: viewing a question's original source code
  # PTID #151852012
  And I pending   #need to implement JS test here to test Uploading File
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'source_code_test.txt'
  And I am on the CourseQuestionBank home page
  When I press button "copy_source_button" for problem containing "This is a source code test"
  Then I should see "What's your favorite creative color?"
  
@javascript
Scenario: copying a question's original source code
  # PTID #151852012
  And I pending   #need to implement JS test here to test Uploading File
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'source_code_test.txt'
  And I am on the CourseQuestionBank home page
  When I press button "copy_source_button" for problem containing "This is a source code test"
  Then the clipboard should contain "What's your favorite creative color?"
