Feature: Structure Content
  In order to structure the content
  As a contributor
  I want to use simplified markup ("markdown") for general text on the games page


  Scenario: short link, no name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a short link without a name
    Then I should see the game
    And I should see a short link without protocol and trailing backspace

  Scenario: long link, no name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a long link without a name
    Then I should see the game
    And I should see a long link shortened without protocol

  Scenario:  link with name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a link with a name
    Then I should see the game
    And I should see the link as a name

  Scenario: Don't die when rendering email addresses
		Given a game Tetris with the description bug@example.com
		When I visit the game article page
		Then I should see the game's description