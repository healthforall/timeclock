require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "employee"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end
