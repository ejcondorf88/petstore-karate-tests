Feature: Update user reusable action

Scenario: Update user account
  Given url baseUrl
  And path 'user', username
  And request updateData
  When method put
  Then status 200
  * def result = response
