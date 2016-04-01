Feature: User can search for questions by tags
  As an exam writer,
  So that I can ensure consistency between versions of tests,
  I want to easily find related questions tagged with the same topic

  As a student,
  So that I can practice topics I’m unconfident in,
  I want to easily find related questions tagged with the same topic

  As a UGSI,
  So that I can help students review material in discussion,
  I want to easily find related questions tagged with the same topic


  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'foo.txt'
    And I am on the CourseQuestionBank home page
    And I follow "View 60"


  Scenario: search for matching questions by a specific tag
    When I fill in "Tags" with "test_tag"
    And I press "Search"
    Then I should see "implied port number"
    And I should see "handling views"
    And I should not see "complicated to scale"
    And I should not see "An HTTP request"

  Scenario: search with multiple tags
    When I fill in "Tags" with "test_tag, test_tag2"
    And I press "Search"
    Then I should see "handling views"
    And I should not see "implied port number"
    And I should not see "complicated to scale"
    And I should not see "An HTTP request"

  Scenario: search by a tag that doesn’t match any questions (sad path)
    When I fill in "Tags" with "not_a_tag"
    And I press "Search"
    Then I should see "No questions matched your search criteria"
    And I should not see "handling views"
    And I should not see "implied port number"
    And I should not see "complicated to scale"
    And I should not see "An HTTP request"
