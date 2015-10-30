require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^I am logged in as a supervisor$/ do
  visit employees_path()
end

Given /^I am viewing (.*)'s timesheet$/ do |employee_name|
  visit "/employees/3/timesheets/5/show"
end

When /^I follow Approve this timesheet$/ do
  #find_link('Edit info')
  page.should have_content("Edit info")
end

Then /^I should see the status turn to be approved/ do

end