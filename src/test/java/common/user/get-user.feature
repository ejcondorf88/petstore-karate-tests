Feature: Get user reusable action

Scenario: Get user by username
  Given url baseUrl
  And path 'user', username
  When method get
  * def result = response
