require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))





When (/I click "Vacation request"/) do
  click_link('Vacation request')
end

When (/I press the "Send email to supervisor"/) do 
  click_button('Send email to supervisor')
end




