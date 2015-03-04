# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
	movies_table.hashes.each do |movie|
		# each returned element will be a hash whose key is the table header.
		# you should arrange to add that movie to the database here.
		Movie.create!(movie)
	end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
	#  ensure that that e1 occurs before e2.
	#  page.body is the entire content of the page as a string.
	#thanks, stackoverflow http://stackoverflow.com/questions/9741716/regular-expression-to-match-if-string-a-appears-before-string-b-on-a-page-using
  first = page.body.index(e1) or assert false
  second = page.body.index(e2, first) or assert false # start looking for e2 after position of first
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	# HINT: use String#split to split up the rating_list, then
	#   iterate over the ratings and reuse the "When I check..." or
	#   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	ratings = rating_list.split(", ")
	if uncheck then 
		ratings.each {|rating| uncheck(rating)}
	else
		ratings.each {|rating| check(rating)}
	end
end

# Then /I press (.*)/ do |button|
# 	click_button(button)
# end



Then /I should (not )?see movies with rating (.*)/ do |filter, ratings_list|
	ratings = ratings_list.split(", ")
  if filter then
    ratings.each {|rating| Then %{I should not see /^#{rating}$/ within "table#movies"}}
  else
    ratings.each {|rating| Then %{I should see /#{rating}/ within "table#movies"} }
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #Then %{I should see movies with rating G, PG, PG-13, R}
  puts page.all('table#movies tr').count
  assert page.all('table#movies tr').count == Movie.count + 1
end

Then /^the director of "(.+)" should be "(.+)"$/ do |movie, director|
	assert Movie.find_by_title(movie).director == director
end

Then(/^I press ratings_submit$/) do
	click_button('ratings_submit')
end