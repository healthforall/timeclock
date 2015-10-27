@no-txn
Feature: Send email
  As an employee or supervisor
  I want to send a email to supervisor
  So that I can request vacation.

  Scenario: Successful Login
    #Given CLIENT_ID and CLIENT_SECRET are set
    Given I am currently on the login page
    When I follow "Send email to request vacation"

    Then I should see "Email has been sent successfully"
