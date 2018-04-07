Feature: A pending request status
  As a user,
  I should be able to view the details of my pending request
  So that I can monitor where it is

  Scenario: Viewing the status of a pending request
    Given I am on "Pending Requests" page
    When I click on one of the pending request's field
    Then I should be able to see the list of people who have already signed the request
      And I should be able to see when it was signed
      And I should be able to see the list of people who are yet to approve the request

  Scenario: Cancelling a pending request
    Given I am on "Pending Request Status" page
    When I click on the "Cancel request" button
    Then I should be able to cancel the job request that I have sent regardless of the people who have already approved it
