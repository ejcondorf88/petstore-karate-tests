Feature: Create user reusable action

Scenario: Create user account
  Given url baseUrl
  And path 'user'
  And request userData
  When method post
  Then status 200
  * def result = response
