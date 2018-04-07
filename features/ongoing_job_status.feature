Feature: An ongoing job status
  As a user
  I should be able to view the details of my ongoing request
  So that I will know when it is done

  Scenario: Viewing the status of an on going job
    Given I am on the ongoing jobs page
    When I click on one of the ongoing job's field
    Then I should be able to see the steps that have already been taken regarding the completion of the jobs
      And I should be able to see the list of people responsible for the completion of the job
      And I should be able to see the current stage being taken to complete the job
      And I should be able to see the date upon which each stage was taken/finished
