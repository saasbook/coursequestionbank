# filter by tags - the filtertags.feature file

Given(/^the following questions have the following tags$/) do |table|
	table.rows_hash.each do |hash|
		puts hash
	end
end

Given(/^the tags table$/) do |table|
	table.rows_hash.each do |tag, question|
		When %{I fill in "#{tag}" with "#{question}"}
	end
end

When(/^I select "(.*?)" in filters$/) do
	click_link(link)
end

Then(/^I should see the question "(.*?)" before "(.*?)"$/) do |arg1, arg2|
  assert page.body =~ /#{e1}.*#{e2}/m
end

Then(/^I should not see the question "(.*?)" before "(.*?)"$/) do |arg1, arg2|
  assert page.body =~ /#{e2}.*#{e1}/m
end

# filter by collections