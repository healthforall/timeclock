@no-txn
Feature: ExportCurrentTimeSheet
  As an employee
  I want to export my current timesheet as an excel document
  So that I can get a paper copy, and so my organization can keep a paper trail

  Scenario: Export as Excel Document
    Given I am logged in
    Given I am on current timesheet
    When I click the Export Timesheet link
    Then I should get a download with the filename "current.xls"
