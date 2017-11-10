Feature: show answer directly
  As a student/instructor/admin
  So that I can study the answer
  I want to show the answer directly

  Background:
    Given I am signed in with uid "1234" and provider "github"
    Given I am on the upload page
    And I attach the file "features/test_files/bloom_test.txt" to "file_upload"
    And I press "Upload File"
    Then I should see "Upload successful!"

  Scenario: I want to show the answer directly
    And I am on the CourseQuestionBank home page
    And I should see "Which of the following best identifies the four basic operations supported by RDBMS?"
    And I press "Check Answer"
    Then I should see "CRUD"
