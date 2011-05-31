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
