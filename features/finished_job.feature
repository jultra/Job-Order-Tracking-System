Feature: View Finished Jobs
  As a user
  I should be able to click one of the finished Job
  So that I can evaluate it

Scenario: View details of finished job
  Given I am on Finished Jobs page
  When I press "View Details"
  Then I should see the details of the job

Scenario: Evaluate finished job
  Given I am on Finished Jobs page
  When I press "Evaluate Job"
  Then I should be able to evaluate the job
