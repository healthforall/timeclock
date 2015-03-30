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
  #session['uid'] = @employee.uid
end

Given /I am logged in/ do
  employee
  visit "fakelogin/#{employee.uid}"
end

Given /^(?:|I )am clocked (.+)$/ do |clockin_status|
  #create an employee that is checked in or out
  if clockin_status == 'clockin'
    @employee.clock_in(true)
  else
    @employee.clock_in(false)
  end
end

When /^(?:|I )navigate to my (.+)$/ do |page_name|
  visit path_to(page_name, @employee)
end

Then /^(?:|I )should (\S*)\s*see the (\S+) (\S+)$/ do |should_see, element_name, element_type|
  if should_see
    print page.html
    expect(page).to have_selector('#clockin' , visible: true)
  else
    page.find(".#{element_type}s .#{element_type}[id='#{element_name}']", :visible => false)
  end
end
