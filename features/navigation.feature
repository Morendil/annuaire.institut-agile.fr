Feature: Home page
  As a new visitor
  I want to be met with a greeting of some sort
  And I want the site's navigation to be consistent
  So that I get over this "where am I" feeling

 Scenario:
   When I go to the home page
   Then I should see "Bienvenue"

 Scenario:
   When I go to the home page
   Then I should see "Les pratiques" within "#header li+li a"

 Scenario:
   When I go to a missing page
   Then I should see "Page introuvable"

 Scenario:
   When I go to an asset file
   Then I should not see "Page introuvable"

