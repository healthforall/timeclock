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

Given(/I am logged in/) do
  employee
  visit "/fakelogin/#{@employee.uid}"
end

Given(/^(?:|I )am clocked in/) do
    @employee.clock_in("true")
    expect(@employee.clockin?).to eq(true)
end

Given(/^(?:|I )am clocked out/) do

end

Given /I am on (.+)$/ do |page_name|
  visit path_to(page_name, @employee)
end

When(/^(?:|I )navigate to my (.+)$/) do |page_name|
  visit path_to(page_name, @employee)
end

When(/^I click the (.+) button$/) do |button_id|
  click_button(button_id)
end

Then(/^I should see the (.+) button$/) do |button_id|
  expect(page.find_button(button_id).text).to eq(button_id)
end

Then(/^I should be clocked (.+)$/) do |clock_status|
  if clock_status == "in"
    expect(@employee.clockin?).to eq(true)
  else
    expect(@employee.clockin?).to eq(false)
  end
end
