Feature: Delete user reusable action

Scenario: Delete user account
  Given url baseUrl
  And path 'user', username
  When method delete
  * def result = response
