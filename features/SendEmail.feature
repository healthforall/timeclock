Feature: Send email
  As an employee
  I want to send a email to supervisor
  So that I can request vacation.

  Scenario:
    Given I am logged in
    Given I am on current timesheet
    When I click "Vacation request"
    When I press the "Send email to supervisor"
    Then I should see "Email has been sent successfully"
 
   
    

