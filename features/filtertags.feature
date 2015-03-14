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

  | tags    | question          | 
  | twitter | twitter questtion |
  | quiz1   | cucumber          |
  | quiz3   | rails question    |
  | quiz1   | twitter question  |
  | rails   | rails question    |
  | testing | cucumber          |
  | testing | rspec             |

  Scenario: restrict to questions with 'quiz1' tag
    When I search for the following tag: 'quiz1'

    Then I should see "twitter question"
    Then I should see "cucumber"
    And I should not see "rails question"
    And I should not see "rspec"

  Scenario: enter no tags
    When I search for the following tags: ‘’
    Then I should see all questions


  



