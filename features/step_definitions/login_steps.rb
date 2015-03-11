Given /^I am signed in with provider "([^\"]*)"$/ do |provider| 
	visit login_path
	visit "/auth/#{provider.downcase}"
end


Given /I am not logged in/ do
	page.driver.browser.post('/logout', user_id: "12345")
end

Given /login was unsuccessful/ do
	visit auth_failure_path
end