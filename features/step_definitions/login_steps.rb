Given /^I am signed in with provider "([^\"]*)"$/ do |provider| 
	visit login_path
	visit "/auth/#{provider.downcase}"
end

Given /^I am signed in with uid "([^\"]*)" and provider "([^\"]*)"$/ do |uid, provider| 
	@instructor = Instructor.find_by_uid(uid)
	visit login_path
	Instructor.stub(:find_by_provider_and_uid).and_return(@instructor)
	Instructor.stub(:create_with_omniauth).and_return(@instructor)
	visit "/auth/#{provider.downcase}"
end

Given /I am not logged in/ do
	page.driver.browser.post('/logout', user_id: "1234")
end

Given /login was unsuccessful/ do
	visit auth_failure_path
end
