Feature: Add a Job Order Request
  As a user
  I should be able to request for a job order
  So that it will be processed by the designated person

Scenario: Add a job order
  Given I am on Request Form page
  When I fill in the request form
  And I press "Process Request"
  Then I should be on Pending Requests page
  And I should see the new request

Scenario: Cancel adding of job order
  Given I am on Request Form page
  When I fill in the request form
  And I press "Cancel Request"
  Then I should be on Dashboard page
