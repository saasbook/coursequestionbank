Feature: add a tag to existing question
  As an CourseQuestionBank Administrator
  So that I can quickly find questions appropriate for my class
  I want to add tags to questions

  As an CourseQuestionBank Administrator
  So that I will be able to search for related questions,
  I want to tag my questions

  As an CourseQuestionBank Administrator
  So that I can categorize my questions,
  I want to tag my questions

 Background:

  Scenario: adding tag results in that tag being displayed on the page
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I add tag "tag1" to problem "1"
    And I am on the problems page

  Scenario: remove tag
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I add tag "tag1" to problem "1"
    And I am on the problems page
    And I remove tag "tag1" from problem "1"
    And I am on the problems page

  Scenario: adding tags to questions in the collection view
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I follow "My Collections"
    And I follow "1/22/15 (W1 L2)"
    And I check problem containing "Around 2007, the claim"
    And I check problem containing "statements comparing Plan-and-Document"
    And I fill in "tag 1, tag 2" with "tag 1, tag 2"
    And I press "Tag checked problems"
    Then I should see "tag 1"
    And I should see "tag 2"
  
  Scenario: don't fill in any tags in collection view
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I follow "My Collections"
    And I follow "1/22/15 (W1 L2)"
    And I check problem containing "Around 2007, the claim"
    And I check problem containing "statements comparing Plan-and-Document"
    And I press "Tag checked problems"
    Then I should see "You need to enter a tag"

  Scenario: don't check problems in collection view
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I follow "My Collections"
    And I follow "1/22/15 (W1 L2)"
    And I fill in "tag 1, tag 2" with "tag 1, tag 2"
    And I press "Tag checked problems"
    Then I should see "You need to select a problem"
