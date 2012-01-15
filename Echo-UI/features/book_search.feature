Feature: Search books 
  In order to search books
  As a user
  I want to show searched books results

  Scenario: Searching books
    Given I am on the homepage
    When I fill in "Search Query" with "Test Query"
    And I press "Search Books"
    Then I should see "Following Result found"
