#Feature: Statistic view of each question
#  As a instructor, I am able to see the statistics of each question,
#  possibly including the total number of attempts,
#  the correctness percentage associated with only the first attemps.
#  (get the question right in the second attemp does not take into account when we calculate the percentage)
#  the averge number of attemps to get it right(probably not an useful info?)
#  The number of attempts assoiciates with each choice if it is a multiple choice question.
#
#
#Background:
#  Given I am signed in with uid "1234" and provider "github"
#  Then I should see "Admin"
#  And I have uploaded 'group_question_with_image.txt'
#  And I am on the CourseQuestionBank home page
#
#Scenario: I should be able to see the stats visualization of the question
#  Then I should see "correctness"
#  And I should see "Total number of attempts"
#  And I should see "Average attempts to get it right"
#  And I should see "% attempts choosen"
