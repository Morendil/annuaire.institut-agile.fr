Feature: Members Directory
  As an identified visitor to the site
  I want to see a list of who else is there
  In order to find opportunities to connect with like-minded people

  Scenario: List Page
    Given that there is a person "Darth", "Gumby"
    And that there is a person "Fred", "Voxel"
    And that I have authorized LinkedIn as "Laurent Bossavit"
    When I go to the list page
    Then I should see "Darth Gumby"
    And I should see "Fred Voxel"
