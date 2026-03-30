@users
Feature: User API test flows - PetStore API

Background:
* url baseUrl
* def userDataTemplate = read('classpath:data/user-data.json')

@smoke @regression @post @createUser
Scenario: Create user account
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
Then match createRes.result.code == 200

@smoke @regression @get @getUser
Scenario: Get user by username
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
* match createRes.result.code == 200

* def getRes = call read('classpath:common/user/get-user.feature') { username: '#(uniqueUsername)' }
Then match getRes.result.id == userData.id
And match getRes.result.username == uniqueUsername
And match getRes.result.email == userData.email

@smoke @regression @put @updateUser
Scenario: Update user account - update name and email
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
* match createRes.result.code == 200

* def updateData = deepCopy(userData)
* set updateData.firstName = 'UpdatedFirstName'
* set updateData.email = 'updated_' + generateEmail()
* def updateRes = call read('classpath:common/user/update-user.feature') { username: '#(uniqueUsername)', updateData: '#(updateData)' }
Then match updateRes.result.code == 200

@smoke @regression @get @verifyUpdate
Scenario: Get updated user and verify changes
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
* match createRes.result.code == 200

* def updateData = deepCopy(userData)
* set updateData.firstName = 'UpdatedFirstName'
* set updateData.email = 'updated_' + generateEmail()
* def updateRes = call read('classpath:common/user/update-user.feature') { username: '#(uniqueUsername)', updateData: '#(updateData)' }
* match updateRes.result.code == 200

* def getRes = call read('classpath:common/user/get-user.feature') { username: '#(uniqueUsername)' }
Then match getRes.result.firstName == 'UpdatedFirstName'
And match getRes.result.email == updateData.email

@smoke @regression @delete @deleteUser
Scenario: Delete user account
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
* match createRes.result.code == 200

* def deleteRes = call read('classpath:common/user/delete-user.feature') { username: '#(uniqueUsername)' }
Then match deleteRes.result.code == 200

@edge-case @getUser
Scenario: Get non-existent user - PetStore returns mock data
* def getRes = call read('classpath:common/user/get-user.feature') { username: 'nonexistentuser123' }
Then match getRes.result.username == 'nonexistentuser123'

@edge-case @deleteUser
Scenario: Delete non-existent user - verify response
* def deleteRes = call read('classpath:common/user/delete-user.feature') { username: 'nonexistentuser456' }
* print 'Delete non-existent response:', deleteRes.result
Then assert deleteRes.resultStatus == 404 || deleteRes.resultStatus == 200

@regression @fullFlow
Scenario: Complete CRUD flow - Create, Get, Update, Get, Delete
* def userData = deepCopy(userDataTemplate)
* def uniqueUsername = generateUsername()
* set userData.username = uniqueUsername
* set userData.email = generateEmail()

# Step 1: Create user
* def createRes = call read('classpath:common/user/create-user.feature') { userData: '#(userData)' }
* match createRes.result.code == 200
* print 'Created user:', uniqueUsername

# Step 2: Get user and verify
* def getRes1 = call read('classpath:common/user/get-user.feature') { username: '#(uniqueUsername)' }
* match getRes1.result.username == uniqueUsername
* match getRes1.result.email == userData.email
* print 'Retrieved user:', getRes1.result

# Step 3: Update user (name and email)
* def updateData = deepCopy(userData)
* set updateData.firstName = 'UpdatedName'
* set updateData.email = 'updated_' + generateEmail()
* def updateRes = call read('classpath:common/user/update-user.feature') { username: '#(uniqueUsername)', updateData: '#(updateData)' }
* match updateRes.result.code == 200
* print 'Updated user:', updateRes.result

# Step 4: Get updated user and verify changes
* def getRes2 = call read('classpath:common/user/get-user.feature') { username: '#(uniqueUsername)' }
* match getRes2.result.firstName == 'UpdatedName'
* match getRes2.result.email == updateData.email
* print 'Verified updated user:', getRes2.result

# Step 5: Delete user
* def deleteRes = call read('classpath:common/user/delete-user.feature') { username: '#(uniqueUsername)' }
* match deleteRes.result.code == 200
* print 'Deleted user:', deleteRes.result

* print 'Full CRUD flow completed successfully!'
