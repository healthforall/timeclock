require 'rspec'
require 'spec_helper'
require 'rspec-rails'

describe TimesheetsController do

  describe "show" do
    it "finds the correct employee"
    it "finds the correct timesheet"
    it "shows the view for that timesheet"
    it "should decide to render the timesheet show view" do
      result.should render_template('show')
    end
  end

  describe "current" do
    it "finds the correct employee"
    it "finds the current timesheet"
    it "shows the view for the current timesheet" #????
  end

  describe "update" do

  end

  describe "select" do

  end

  describe "massExport" do

  end

end