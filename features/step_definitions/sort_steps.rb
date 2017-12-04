Given /the following problems exist/ do |problems_table|
  instructor = Instructor.find_by_uid("1234")
  problems_table.hashes.each do |problem|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    problem[:is_public] = true
    prob = instructor.problems.create!(problem)
    prob.tags.create(name: problem[:text])
  end
  Problem.reindex
  #fail "Unimplemented"
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  pending
  # #  ensure that that e1 occurs before e2.
  # #  page.body is the entire content of the page as a string.
  # page.body.should =~ /#{e1}.*#{e2}/m 
  # # m means multi line mode
  # #fail "Unimplemented"
end