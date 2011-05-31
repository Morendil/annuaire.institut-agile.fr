Feature: Registration
  As a visitor interested in the site's premise
  I want the site to know my identity
  So that I can use the site's personalized features

  Scenario:
    Given that I am not connected
    When I go to the status pagelet
    Then I should see "Connectez-vous"

  Scenario:
    Given that I am not connected
    When I go to the status pagelet
    And I follow "login" within "body"
    Then I should be redirected within "linkedin.com"

  Scenario:
    Given that I have authorized LinkedIn as "Laurent Bossavit"
    And that I am not registered
    When I go to the callback page
    Then I should be on the home page
    When I go to the status pagelet
    Then I should see "Laurent Bossavit"

  Scenario:
    Given that I have authorized LinkedIn as "Laurent Bossavit"
    And that I am not registered
    When I go to the status pagelet
    Then I should see "Laurent Bossavit"
    And I should see "Inscrivez-vous"
