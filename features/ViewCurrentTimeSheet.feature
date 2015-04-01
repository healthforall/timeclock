@no-txn
Feature: ViewCurrentTimeSheet
  In order to keep track of work hours
  As an employee
  I want to see my current timesheet

  Scenario: Go to page when not checked in
    Given I am logged in
    Given I am clocked out
    When I navigate to my current timesheet
    Then I should see the Clock In button


  Scenario: Go to page when checked in
    Given I am logged in
    Given I am clocked in
    When I navigate to my current timesheet
    Then I should see the Clock Out button