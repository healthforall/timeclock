require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Capybara.server_port = 3000

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

def employee

  @employee = FactoryGirl.create(:employee, :name =>'Employee', :email => "employee20156@gmail.com")
  @employee.save
  return @employee
end

Given /CLIENT_ID and CLIENT_SECRET are set/ do
  #CLIENT_ID=344838088462-grg9rc2bddg2324qt8m7ud1sc3g9pnln.apps.googleusercontent.com
  #CLIENT_SECRET=fpEi5TQ8WDloOyR_msGUMDff
end 

And (/I am currently on the login page/) do
  employee
  visit('/login')
end

When (/I follow "Log in with your gmail account"/) do
  find_link('Log in with your gmail account')[:href].include?('/auth/google_oauth2').should == true
  click_link('Log in with your gmail account')
end

And (/I enter my email and password/) do
  fill_in('Email', with: 'employee20156@gmail.com')
  fill_in('Passwd', with: 'WalkerTheProf')
end

And (/I enter a wrong email and password/) do
  fill_in('Email', with: 'employee201562@gmail.com')
  fill_in('Passwd', with: 'WalkerTheProf')
end

And (/I follow "Sign in"/) do
  click_on('Sign in')
end

Then (/I should be on my current timesheet page/) do
  click_button('Accept')
  uri = URI.parse(current_url)
  "#{uri.path}?#{uri.query}".should == '/employees/1/timesheets/1/current?'
end

Then (/I should be on the login page/) do
  click_button('Accept')
  uri = URI.parse(current_url)
  "#{uri.path}?#{uri.query}".should == '/login'
end