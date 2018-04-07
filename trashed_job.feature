Feature: View Cancelled Jobs
  As a user
  I should be able to click one of the cancelled job request
  So that I can restart the job request

Scenario: View details of cancelled job
  Given I am on the Trash page
  When I press "View Details"
  Then I should see the details of the job

Scenario: Restart cancelled job
  Given I am on the Trash page
  When I press "Restart Request"
  Then I should be able to restart the job request process
