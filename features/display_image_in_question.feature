Feature: User should be able to see image in problem's view
  As an User
  I can see the image if problem contains the image
  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'test_question_with_image.txt'
    And I am on the collection edit page
    

  Scenario: Admin should see image in problem's view
    
    And I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"

  Scenario: Instructor should see image in problem's view
  
    And I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"

  Scenario: Student should see image in problem's view

    Given I am signed in with uid "12345" and provider "github"
    And I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"