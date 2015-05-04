Feature: Edit Timesheet
  In order to fix my timesheet
  As an employee
  I want to edit my timesheet

  Scenario: Edit Time Cell
    Given I am logged in
    And I am viewing my current timesheet
    When I edit a time cell to 10:00
    Then I should see the Submit Changes button
