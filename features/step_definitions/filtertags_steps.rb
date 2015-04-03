# filter by tags - the filtertags.feature file

When(/^I search for the following tag: (.+)/)  do |arg1|
 	choose(arg1)
end

Then(/^I should see all questions$/) do
  assert(page.all('table#problems tr').count - 1 == Problems.all.count)
end
