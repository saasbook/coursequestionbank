Feature: viewing other collections
	As an instructor
	I should be able to explore other collections of other instructors 
	So that I can add them to my collection

	Scenario: clicking on a collection in the search page
		When I am on the coursequestionbank homepage
		And I click on 'other_collection'
		Then I should see a list of problems in 'other_collections'