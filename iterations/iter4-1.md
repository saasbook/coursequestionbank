New Features:
1. An instructor / admin preview the question, is it possible to get a summary of the difficulty of the question
Students can have multiple tries, but we record:
the first attempt 
Also record # attempts by the student
format: (the student, question ID, answer, #attempts)
side notes: Item response theory using sigmoid function to represent the difficulty and the students’ performance for each problems. This is could be a candidate, but he stats model and the stats visualization is left to “close to modification but open for extension. The basic model and visualization need to be implemented in a simple basic but solid way. 
2. Stretch feature:
Edx can export spreadsheet of all students answer this question. Want CQB can import that file, and update the difficulty bar. 
Two suggestions:
Have access store attributes before import/export
If spreadsheet has question ID column, then can import CQB. -> next step: find match questions between EDX and CQB. 
If it does not, then we need to manually add that column
Automatic import based on Edx (lower priority), first check if the format and the ID are compatible.
3.Fail gracefully for group question - if didn’t implement that feature, raise an exception.
Todos: 
1.Pull request to the main CQB repo. Collapse all the commits to a big one commits, then pull request. 
2.Wrap up the repo and improve documentation for the next phase of the project. Make it more DRY and self-explanatory if possible. 
