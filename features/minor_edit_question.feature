Feature:
  As an instructor/Admin, I want to do minor edit on a question

Scenario: I edit the question slightly
  Given I am signed in with uid "1234" and provider "github"
  Then I should see "Admin"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page
  Then I should see "Update"
  And I follow "Update"
  And I press "Confirm Update"
  Then I should see "Which of the following best identifies the four basic operations supported by RDBMS?"

Scenario: I edit the question, then I regreted that I was editing too much on this question
  Given I am signed in with uid "1234" and provider "github"
  Then I should see "Admin"
  And I have uploaded 'test_question_with_image.txt'
  And I am on the CourseQuestionBank home page
  Then I should see "Update"
  And I follow "Update"
  And I press "Confirm Update"
  Then I should see "An HTTP request must consist of both"