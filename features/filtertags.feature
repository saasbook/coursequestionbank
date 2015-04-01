Feature: display list of questions filtered by tag
  As an instructor
  So that I can quickly find questions appropriate for my class
  I want to find questions matching only certain tags

  Background: I am logged in and on the course question bank homepage
    Given I am signed in with provider "github" 
    Given I go to the homepage

  Scenario: restrict to questions with "quiz1" tag
    When I search for the following tag: "quiz 1"

  Scenario: enter no tags
    When I search for the following tag: ""
    Then I should see all questions


  



