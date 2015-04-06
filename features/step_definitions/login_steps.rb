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

Given /I am on the login page/ do
  visit('/login')
end

When /I follow "Log in with your gmail account"/ do
  find_link('Log in with your gmail account')[:href].include?('/auth/google_oauth2').should == true
  click_link('Log in with your gmail account')
end

And /I enter my email and password/ do
  fill_in('Email', with: 'employee20156@gmail.com')
  fill_in('Passwd', with: 'WalkerTheProf')
end

And /I follow "Sign in"/ do
  click_on('Sign in')
end

Then /I should be on my current timesheet page/ do
  pending
  #uri = URI.parse(current_url)
  #"#{uri.path}?#{uri.query}".include?(/\/employees\/\d\d\/timesheets\/\d\/current$/).should == true
end