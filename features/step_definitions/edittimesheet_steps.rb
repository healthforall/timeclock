require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

def employee
  @employee = FactoryGirl.create(:employee)
  @employee.save
  return @employee
end

Given(/^(?:|I )am viewing my (.+)$/) do |page_name|
  visit path_to(page_name, @employee)
end

When(/^(?:|I )double-click a time cell$/) do
  expect(find(:xpath, "(//td[2])[1]")['contenteditable']).to eq('false')
  find(:xpath, "(//td[2])[1]").double_click
end

When(/^(?:|I )double-click the last time cell of a day$/) do
  find(:xpath, "(//td[2])[1]").double_click
end

When(/^(?:|I )edit a time cell to (.+)$/) do |input|
  cell = "(//td[2])[1]"
  find(:xpath, cell).set(input)
end

Then(/^(?:|The )cell should be editable$/) do
  expect(find(:xpath, "(//td[2])[1]")['contenteditable']).to eq('true')
end

Then(/^A new row should appear below it$/) do

end