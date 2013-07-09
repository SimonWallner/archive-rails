Feature:
  As a contributor
  In order to add additional info to my game
  I want to add different fields with content to my game

  Background:
    Given I am signed in as User

  @javascript
  Scenario: add game field data with valid data
    Given I am on the game creation page
    When I enter valid game data
   	And I enter valid data into the field "Developer"
	  And I enter valid data into the field "Publisher"
	  And I enter valid data into the field "Distributor"
	  And I enter valid data into the field "Credits"
	  And I enter valid data into the field "Release Dates"
	  And I enter valid data into the field "External Links"
	  And I enter valid data into the field "Aggregate Scores"
	  And I enter valid data into the field "Review Scores"
	  And I enter valid data into the field "Series"
	  And I enter valid data into the field "Userdefined"
	  And I submit it
	  Then I should see the saved Game fields

	@javascript
	Scenario: add game field with token list
 		Given I am on the game creation page
		When I enter valid game data
		And I enter field with token list "Platform"
		And I enter field with token list "Mode"
		And I enter field with token list "Media"
		And I enter field with token list "Genres"
		And I enter field with token list "Tags"
		And I submit it
		Then I should see the saved token list data

  @javascript
  Scenario: add Release Dates without day
    Given I am on the game creation page
    When I enter valid game data 
    And I enter field of Release Dates without day
    And I submit it
    Then I should not see an error
    
    
  @javascript
  Scenario: add Release Dates without month
    Given I am on the game creation page
    When I enter valid game data 
    And I enter field of Release Dates without month
    And I submit it
    Then I should see error for month
    
    
     