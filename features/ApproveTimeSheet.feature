Feature: Approve Timesheet
  As a supervisor
  I want to click an approval button
  So that I can approve my employee's timesheet

  Scenario:
    Given I am logged in as a supervisor
    When I am viewing employee's timesheet
    When I follow "Approve this timesheet"
    Then I should see "Approved"
    When I follow "Disapprove this timesheet"
    Then I should see "NOT Approved"