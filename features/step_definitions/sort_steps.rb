Given /the following problems exist/ do |problems_table|
  problems_table.hashes.each do |problem|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Problem.create!(problem)
  end
  #fail "Unimplemented"
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m 
  # m means multi line mode
  #fail "Unimplemented"
end