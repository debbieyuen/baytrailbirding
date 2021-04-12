Feature: Homepage Layoute
  As a product manager
  I want users to see the fully loaded homepage
  So that they are able to use the app succesfully

  Scenario: User sees all elements of the homepage.
    When I go to the homepage
    Then I should see the organization name
    Then I should see the sidebar cards
    Then I should see the map placeholder