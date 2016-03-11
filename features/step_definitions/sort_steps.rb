Given /the following problems exist/ do |problems_table|
  problems_table.hashes.each do |problem|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Problem.create!(problem)
  end
  #fail "Unimplemented"
end

Given I search "nonexistent problem"