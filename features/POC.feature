
Feature: Test API create user

@Scenario1 @Full
Scenario: Get user information

Given I have set a connection to todo.ly service
When I send a POST request to user/login with json
"""
{
"username":"root",
"password":"root"
}
"""
Then I expect HTTP code 200
