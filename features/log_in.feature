Feature: A log in page and mechanism for users
  As a user
  I should be able to log in to my account
  So that I can view my dashboard

  Scenario: Logging in to the account with correct username and password information
    Given I am on the log_in page
    When I type my "correct_username" on the "username" field
      And I type my "correct_password" on the "password" field
      And I click the "Submit" button
    Then I should be able to go to my account dashboard

  Scenario: Logging in to the account with incorrect username or password information
    Given I am on the log_in page
    When I type my "incorrect_username" on the "username" field
      And I type my "incorrect_password" on the "password" field
      And I click the "Submit" button
    Then I should be redirected to the log_in page
      And I should be able to see a message saying "Username/password is incorrect"
