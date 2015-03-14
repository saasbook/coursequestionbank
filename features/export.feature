Feature: export a collection of ruql questions into a HTML5 or XML ready view.
	As an instructor
	So that I can create tests to give to my students
	I want to be able to export questions that I have put into collections into an HTML5 or XML view.

	Scenario: export questions
	  Given I create a collection with ‘foo’ and ‘bar’ 
	  And I follow ‘export questions’
	  Then I should see options for ‘HTML5’ and ‘XML’
	  When I follow ‘HTML5’ 
	  I should see within the page ‘Question 1’