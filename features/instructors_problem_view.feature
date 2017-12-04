Feature: Instructor's view of problem table, aka /problems, /homepage
  As an instructor, I should see the edit panel for each question if the question belong to the instructor.
  I should not see the edit panel if the problems belongs to others.


  Background:
    Given I am signed in with uid "1234" and provider "github" 
    And I have uploaded 'bloom_test.txt'
    Then I am signed in with uid "123456" and provider "developer"

  Scenario: I should be identified as instructor:
    When I am on the CourseQuestionBank home page
    Then I should see "Instructor!"

  Scenario: I can not see the edit panel of problems doe not belong to me
    When I am on the CourseQuestionBank home page
    And I should see "Belongs to collections:"
    And I should see "Bloom category:"
    And I should see "Edit question:"

  Scenario: I can see the edit panel of the problems belong to me
    Given I am signed in with uid "1234" and provider "github" 
    When I am on the CourseQuestionBank home page
    Then I should see "Which of the following best identifies the four basic operations supported by RDBMS?"
    And I should see "Belongs to collections:"
    And I should see "Bloom category:"
    And I should see "Edit question:"




