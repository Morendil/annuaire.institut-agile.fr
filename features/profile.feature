Feature: Member profile
  As a registered visitor of the site
  I want to see a summary of my activities on an easily reachable page
  So that I know what this site tracks about me

  Scenario: Profile Page
    Given that I am registered as "Laurent Bossavit"
    When I go to the profile page
    Then I should see "Laurent Bossavit" within "body"
