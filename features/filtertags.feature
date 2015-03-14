Feature: display list of questions filtered by tag
  As an instructor
  So that I can quickly find questions appropriate for my class
  I want to find questions matching only certain tags

  Background: the following questions have been added

  Given the following questions have the following tags
  | question         | tags    | 
  | twitter question | quiz1   | 
  | twitter question | twitter | 
  | rails question   | rails   | 
  | rails question   | quiz3   | 
  | cucumber         | quiz1   |
  | cucumber         | testing | 
  | rspec            | testing | 

  Given the tags table 
  | tags    |  question         | 
  | twitter | twitter questtion |
  | quiz1   | cucumber          |
  | quiz3   | rails question    |
  | quiz1   | twitter question  |
  | rails   | rails question    |
  | testing | cucumber          |
  | testing | rspec             |

  Scenario: restrict to questions with 'quiz1' tag
    When I search for the following tag: 'quiz1'
    Then I should see question "twitter question"
    Then I should see question "cucumber"
    And I should not see question "rails question"
    And I should not see question "rspec"

  Scenario: enter no tags
    When I search for the following tags: ‘’
    Then I should see all questions

  Scenario: sort by created date
    When I select 'created_date' in filters
    Then I should see the question "twitter question" before "rspec"
    And I should not see "cucumber" before "rails question"

  Scenario: filter by created by
    When I select ‘sort by author’ in filters
    Then I should see the question "twitter question" before "rspec"
    And I should not see the question "cucumber" before "twitter question" 


  



