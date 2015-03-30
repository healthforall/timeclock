Feature: ViewCurrentTimeSheet
  In order to keep track of work hours
  As an employee
  I want to see my current timesheet

  Scenario: Go to page when not checked in
    Given I am logged in
    Given I am clocked out
    When I navigate to my current timesheet
    Then I should see the clockin button
    Then I should not see the clockout button

  Scenario: Go to page when checked in
    Given I am clocked in
    When I navigate to my current timesheet
    Then I should see the clockout button
    Then I should not see the clockin button