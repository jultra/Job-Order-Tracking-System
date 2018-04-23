Feature: Add a Job Order Request
  As a user
  I should be able to request for a job order
  So that it will be processed by the designated person

Scenario: Add a job order
  Given I am on Request Form
  When I fill in "control_no" with "123"
    And I fill in "where" with "asd"
    And I fill in "date_needed" with "10/22/18"
    And I fill in "time_needed" with "12:00"
    And I fill in "problem_areas" with "asd"
    And I fill in "requester" with "bea"
    And I fill in "adviser" with "ultra"
    And I fill in "fund_source" with "123"
    And I press "submit"
  Then I should be on Pending Requests
    And I should be able to see the new request

Scenario: Cancel adding of job order
  Given I am on Request Form
  When I fill in "control_no" with "123"
    And I fill in "where" with "asd"
    And I fill in "date_needed" with "10/22/18"
    And I fill in "time_needed" with "12:00"
    And I fill in "problem_areas" with "asd"
    And I fill in "requester" with "bea"
    And I fill in "adviser" with "ultra"
    And I fill in "fund_source" with "123"
    And I press "cancel"
  Then I should be on Dashboard
