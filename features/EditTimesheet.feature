Feature: Edit Timesheet
  In order to fix my timesheet
  As an employee
  I want to edit my timesheet

  Scenario: Double-Click Time Cell
    Given I am logged in
    And I am viewing my current timesheet
    When I double-click a time cell
    Then The cell should be editable

  Scenario: Edit Time Cell
    Given I am logged in
    And I am viewing my current timesheet
    When I edit a time cell to 10:00
    Then I should see the Submit Changes button

  Scenario: Double-Click Day's Last Time Cell
    Given I am logged in
    And I am viewing my current timesheet
    When I double-click the last time cell of a day
    Then A new row should appear below it