Feature: Registration
  As a visitor interested in the site's premise
  I want the site to know my identity
  So that I can use the site's personalized features

  Scenario: Invitation to connect
    Given that I am not connected
    When I go to the status pagelet
    Then I should see "Connectez-vous"

  Scenario: Login via LinkedIn
    Given that I am not connected
    When I go to the status pagelet
    And I follow "login" within "body"
    Then I should be redirected within "linkedin.com"

  Scenario: Finishing login
    Given that I have authorized LinkedIn as "Laurent Bossavit"
    And that I am not registered
    When I go to the callback page
    Then I should be on the home page
    When I go to the status pagelet
    Then I should see "Laurent Bossavit"

  Scenario: Invitation to register
    Given that I have authorized LinkedIn as "Laurent Bossavit"
    And that I am not registered
    When I go to the status pagelet
    Then I should see "Laurent Bossavit"
    And I should see "Inscrivez-vous"

  Scenario: Registering
    Given that I have authorized LinkedIn as "Laurent Bossavit"
    And that I am not registered
    When I go to the status pagelet
    And I follow "register" within "body"
    Then I should be on the registration page
    And I should see "Laurent" in input "first_name"
    And I should see "Bossavit" in input "last_name"
    And the "agree" checkbox should be checked
    When I press "finish"
    Then I should see "Félicitations"
    And there should be a person "Laurent", "Bossavit"
