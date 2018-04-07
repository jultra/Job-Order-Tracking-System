Feature: Navigate through the website
  As a user
  I should be able to interact with the website
  So that I can avail services

Scenario: Show Dashboard page
  Given I am on any page of the website
  When I press "Dashboard"
  Then I should see "Dashboard" page

Scenario: Show Job Order form
  Given I am on any page of the website
  When I press "Add Job Order"
  Then I should see "Request Form" page

Scenario: Show Pending Requests
  Given I am on any page of the website
  When I press "Pending Requests"
  Then I should see "Pending Requests" page

Scenario: Show Ongoing Jobs
  Given I am on any page of the website
  When I press "Ongoing Jobs"
  Then I should see "Ongoing Requests" page

Scenario: Show Finished Jobs
  Given I am on any page of the website
  When I press "Finished Jobs"
  Then I should see "Finished Jobs" page

Scenario: Show Trash
  Given I am on any page of the website
  When I press "Trash"
  Then I should see "Thrash" page 
