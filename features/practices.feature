Feature: Agile Practices
  As a site participant
  I want to maintain a structured record of the agile practices I've learned
  So as to make this learning more valuable, for myself and others

  Background:
    Given that I am registered as "Laurent Bossavit"
    And that there is a practice "stories" with title "User Stories"

  Scenario: List practices on profile page
    Given that I have added experience with "stories"
    When I go to the profile page
    Then I should see "J'utilise..." 
    And I should see "User Stories" within ".practices"

  Scenario: Add practice
    When I go to the profile page
    And I select "User Stories" from "practice" within "#add"
    And I press "addit" within "#add"
    When I go to the profile page
    Then I should see "User Stories" within ".practices"

