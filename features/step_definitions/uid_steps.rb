Then /^the problem containing "(.*)" should have a non-empty uid/ do |problem_text|
  @orig_prob_uid = problems_with_text(problem_text)[0].uid #check uuid exists in database for this problem and is not nil
  assert @orig_prob_uid
end

Then /^the problem containing "(.*)" should not have the uid of the original problem/ do |problem_text|
  assert problems_with_text(problem_text)[0].uid != @orig_prob_uid
end

And(/^I try to upload a file with a duplicate question$/) do
  page.driver.browser.post('/upload', "myfile" => "test_files/redundant_universal_id.txt")
end