require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

def supervisor
  @supervisor = FactoryGirl.create(:employee,:admin => true)
  @supervisor.save
  return @supervisor
end
Given /^I am logged in as a supervisor$/ do
  employee
  supervisor
  visit "/fakelogin/#{@supervisor.uid}"
end

Given /^I am viewing (.*)'s timesheet$/ do |employee_name|
  visit path_to("current timesheet",@employee)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

