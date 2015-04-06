Feature: Clock In and Out
  In order to keep track of work hours
  As an employee
  I want to clock in and out

  Scenario: Clock In
    Given I am logged in
    And I am clocked out
    When I navigate to my current timesheet
    And I click the Clock In button
    Then I should be clocked in

  Scenario: Clock Out
    Given I am logged in
    And I am clocked in
    When I navigate to my current timesheet
    And I click the Clock Out button
    Then I should be clocked out