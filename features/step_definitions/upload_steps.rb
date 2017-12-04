Given(/^I have selected a file to upload$/) do
  page.driver.browser.post('/upload', "myfile" => "test_files/foo.txt")
end

Given(/^I press the upload button$/) do

  click_button "Upload File"
end

Given(/^I press the private button$/) do

  click_button "Private"
end

Given(/^I press the update button$/) do

  click_button "Update"
end

Given(/^the upload fails$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a flash message telling me of failure$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I successfully upload a file$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I press upload without selecting a file$/) do
  params["myfile"] = nil
end

Then(/^I should see a flash message asking me to select a file$/) do
  flash[:notice] = "Please select a file"
end
