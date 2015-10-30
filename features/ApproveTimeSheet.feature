Feature: Approve Timesheet
  As a supervisor
  I want to click an approval button
  So that I can approve my employee's timesheet

  Scenario:
    Given I am logged in as a supervisor
    And I am viewing Zach's timesheet
    When I follow Approve this timesheet
    Then I should see the status turn to be approved