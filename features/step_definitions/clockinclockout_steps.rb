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

#emp = FactoryGirl.create(:employee)
#emp.save
def employee
 @employee = FactoryGirl.create(:employee)
 @employee.save
 return @employee
  #session['uid'] = @employee.uid
end

Given /I am logged in/ do
  employee
  visit "/fakelogin/#{@employee.uid}"
end

Given /^(?:|I )am clocked in/ do
    @employee.clock_in("true")
    expect(@employee.clockin?).to eq(true)
end

Given /^(?:|I )am clocked out/ do

end

When /^(?:|I )navigate to my (.+)$/ do |page_name|
  visit path_to(page_name, @employee)
end

Then(/^I should see the Clock In button$/) do
  expect(page.find_button("Clock In").text).to eq("Clock In")
end

Then(/^I should see the Clock Out button$/) do
  expect(page.find_button("Clock Out").text).to eq("Clock Out")
end

