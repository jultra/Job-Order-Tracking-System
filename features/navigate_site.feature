Feature: Navigate through the website
  As a user
  I should be able to interact with the website
  So that I can avail services

Scenario: Show Dashboard page
  Given I am on any page of the website
  When I go to Dashboard
  Then I should be on Dashboard

Scenario: Show Job Order form
  Given I am on any page of the website
  When I go to Add Job Order
  Then I should be on Add Job Order

Scenario: Show Pending Requests
  Given I am on any page of the website
  When I go to Pending Requests
  Then I should be on Pending Requests

Scenario: Show Ongoing Jobs
  Given I am on any page of the website
  When I go to Ongoing Jobs
  Then I should be on Ongoing Jobs

Scenario: Show Finished Jobs
  Given I am on any page of the website
  When I go to Finished Jobs
  Then I should be on Finished Jobs

Scenario: Show Trash
  Given I am on any page of the website
  When I go to Trash
  Then I should be on Trash
