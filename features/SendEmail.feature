@no-txn
Feature: Send email
  As an employee
  I want to send a email to supervisor
  So that I can request vacation.

  Scenario: Successful Login
    Given I am logged in
    Given I am on current timesheet
    When I click on "Send email"
    Then I should see "Email has been sent successfully"
