@no-txn
Feature: ExportCurrentTimeSheet
  As an employee
  I want to export my current timesheet as an excel document
  So that I can get a paper copy, and so my organization can keep a paper trail

  Scenario: Export as Excel Document
    Given I am logged in
    When I click the export button
    Then I should get a download with the filename "timesheet.xls"
