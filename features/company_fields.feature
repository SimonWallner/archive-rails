Feature: Company fields
  As a contributor
  In order to add additional info to my company
  I want to add more information about company

  Background:
    Given I am signed in as User
 
  # @javascript
  # Scenario: insert company with valid fields data
  #   Given I am on the company creation page
  #   When I enter valid company data
  #   And I enter company field with "Official Name"
  #   And I enter company field with "Location"
  #   And I enter company field with "Founded"
  #   And I enter company field with "Defunct"     
  #   And I create the company
  #   Then I should see the saved Company fields

	@javascript
  Scenario: add a founding date with only a year
    Given I am on the company creation page
    When I enter valid company data 
    And I enter only a year as the founding date
    And I submit it
    And I should see the founding year

  @javascript  
  Scenario: add a founding date with only month and year
    Given I am on the company creation page
    When I enter valid company data 
    And I enter only a year and moth as the founding date
    And I submit it
    And I should see the founding year and month
		
	@javascript
  Scenario: add a full founding date
    Given I am on the company creation page
    When I enter valid company data 
    And I enter a full founding date
    And I submit it
    And I should see the full founding date
