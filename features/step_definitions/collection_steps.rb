When(/^I click on "(.*?)"$/) do |name|
  @collection = Collection.find_by_name(name)
  visit '/collections/' + @collection.id.to_s
end
