Iteration 2-1

New Features Required:
Add developer Devil Login for testing purposes, including different levels (admin, instructor, and student) of accessibility with corresponding user interface.


redesign the application to allow non-whitelist login and treated users as students by default, this would be a huge change of the application and to the existing database.


render Student’s view of the app as follows (student as a new type of user):
A. disable students’ tag functionality and accessibility
B. disable edit panel for each question.
		  C. disable admin panel for student.
		  D. bloom and collection display remains, collection display as plain text
		  E. students have no access of upload question.
		  F. students have no access of manipulation collection.
		  G. any operation without permission will be forbidden and warned.


Render Instructor's’ view of the app as follows:
   A. tag functionality and accessibility remains for instructors
B. disable edit panel for each question that does not belong to the instructor.
		  C. disable admin panel for instructor.
		  D. instructor should be able to upload question
		  E. instructor should be able to manipulate collections that belongs to him/her
		F. instructor should not be able to see any private collection
		G. instructor should not be able to edit any problem does not belong to him/her


Render Admin’'s view of the app as follows:
		A. tag functionality and accessibility remains for admin
B. edit panel for each question is visible to admin because admin is admin..
		C. admin panel is visible and accessible for admin because admin is admin..
		D. admin should be able to upload question
		E. admin should be able to manipulate collections that belongs to him/her
		F. admin should be able to see any private collection because admin is admin..
G. admin should be able to edit any problem even the problem does not belong  to him/her because admin is admin
(The reason why admin is so powerful is because we need a superuser to sorta keep things in order in an easy way)
		


Implement global explanation of problems in RUQL renderer.
A global explanation is the explanation for every distractor(incorrect answer) without a specific explanation. 
When the global explanation is uploaded as global explanation, it should be maintained that way. It should not be repeated for every distractor.
	     
Collection buttons should be replaced by checkboxes.
There should be plain text showing which collections this question belongs to.
There should be a hide button to collapse all the checkboxes after editing.

***************************************************************************************************************************************************
We have improved and rewrite test cases to be compatible for the newly required features during iteration 2-1
We use pivotal tracker to break down each feature accordingly
