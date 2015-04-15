@no-txn
Feature: Employee Login
  As an employee or supervisor
  I want to login using my gmail account
  So that I can use the site.

  Scenario: Successful Login
    Given CLIENT_ID and CLIENT_SECRET are set
    And I am currently on the login page
    When I follow "Log in with your gmail account"
    And I enter my email and password
    And I follow "Sign in"
    Then I should be on my current timesheet page
	
  Scenario: Failed Login
    Given CLIENT_ID and CLIENT_SECRET are set
    And I am currently on the login page
    When I follow "Log in with your gmail account"
    And I enter a wrong email and password
    And I follow "Sign in"
    Then I should be on the login page