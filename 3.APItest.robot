*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
Get user profile success
    Create Session    reqres    https://reqres.in
    ${response}=    GET Request    reqres    /api/users/12
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}
    ${json_data}=    Convert To String    ${response.json()}
    ${json_response}=    Evaluate    ${json_data}    json
    ${user_data}=    Get From Dictionary    ${json_response}    data
    ${response_id}=    Convert To String    ${user_data['id']}
    Should Be Equal    ${response_id}    12
    Should Be Equal    ${user_data['first_name']}    Rachel
    Should Be Equal    ${user_data['last_name']}    Howell
    Should Be Equal    ${user_data['avatar']}    https://reqres.in/img/faces/12-image.jpg

Get user profile but user not found
    Create Session    reqres    https://reqres.in
    ${response}=    GET Request    reqres    /api/users/1234
    Should Be Equal As Integers    ${response.status_code}    404
    Log    ${response.json()}
    Should Be Empty    ${response.json()}