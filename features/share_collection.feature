Feature: Admin / instructors can share a collection
  As an Admin/ instructor
  I want to share a collection with others
  So the collection that being shared should be on "My collection" and "Public Collection"
  and this collection should not appear on others' "My collection", but should not be in others' "My collection"
  
  
  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the dashboard
    When I am on the admin panel
    And I have uploaded 'bloom_test.txt'

  Scenario: The shared collection should appear on admin's "My collection" and "Public collection"

    When I am on the dashboard
    And I should see "A few example questions"
    Then I should not see "Share"
    When I follow "A few example questions"
    And I should see "Edit this collection"
    Then I follow "Edit this collection"
    And I should see "Public" is checked in "dropdown"
    Then I select "Share" in "dropdown"
    And I should see "Share" is checked in "dropdown"
    Then I press "Update"
    When I am on the dashboard
    Then I should see "Share"

    When I am on the dashboard
    And I should see "A few example questions"
    Then I should see "Share"

    When I follow "A few example questions"
    And I should see "Edit this collection"
    Then I follow "Edit this collection"
    And I should see "Share" is checked in "dropdown"
    Then I select "Private" in "dropdown"
    And I should see "Private" is checked in "dropdown"
    Then I press "Update"
    When I am on the dashboard
    Then I should not see "Share"
    Then I should see "Private"

    When I am on the dashboard
    And I should see "A few example questions"
    Then I should see "Private"
    When I follow "A few example questions"
    And I should see "Edit this collection"
    Then I follow "Edit this collection"
    And I should see "Private" is checked in "dropdown"
    Then I select "Public" in "dropdown"
    And I should see "Public" is checked in "dropdown"
    Then I press "Update"
    When I am on the dashboard
    Then I should see "Public"
