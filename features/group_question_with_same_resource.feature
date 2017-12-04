Feature: User should be able to see group of questions with same resource
  As an User
  I can see one image if a group of questions contains same image

  Scenario: Admin should see image in problem's view if a group of questions contains same image
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'group_question_with_image.txt'
    And I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"
    #And I should see "question1"
    #And I should see "question1-1"
    #And I should see "question1-2"

  Scenario: Instructor should see image in problem's view if a group of questions contains same image
    Given I am signed in with uid "123456" and provider "github"
    And I have uploaded 'group_question_with_image.txt'
    And I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"
    

  Scenario: Student should see image in problem's view if a group of questions contains same image
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'group_question_with_image.txt'
    And I am on the collection edit page
    Given I am signed in with uid "12345" and provider "github"
    When I am on the CourseQuestionBank home page
    Then I should see the image "http://www.websiteoptimization.com/secrets/metrics/10-21-http-request.png"
    