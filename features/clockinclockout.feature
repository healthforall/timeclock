Feature: Check In and Out
  In order to keep track of work hours
  As an employee
  I want to check in and out

  Scenario: Check In
    Given I am not checked in
    And I am on my current timesheet
    Then I should see the checkin button
