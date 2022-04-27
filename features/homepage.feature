Feature: Homepage Layout
  As a product manager
  I want users to see the fully loaded homepage
  So that they are able to use the app succesfully

  Scenario: User sees all elements of the homepage.
    When I go to the homepage
    Then I should see the organization name
    Then I should see the side navigation bar
    Then I should see the map items
    Then I should see the image "/assets/sfbbo-logo-a9bc4664251d23e3c8164e3cea2a193d7c135b8d088792276fb20c923b61168a.png"

  Scenario: User sees all show all pages.
    When I go to the homepage
    Then I go to the locations page
    Then I should see location cards

  Scenario: User sees all show all pages.
    When I go to the homepage
    Then I go to the locations page
    Then I should see location cards
