Feature: Total hours
  As a supervisor
  I want to calculate the total hours of employee's pay period


  Scenario:
    Given I am logged in as a supervisor
    When I am viewing employee's timesheet
    When I edit a time cell to 10:00 AM
    And I edit another time cell to 11:00 AM
    Then I should see the Submit Changes button
    When I click the Submit Changes button
    Then I should see "Total: 1.0 hours"