*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variable ***
${url}    http://the-internet.herokuapp.com/login

*** Test Case ***
Login success
    Open Browser    ${url}    chrome
    Input Text    id=username    tomsmith
    Input Text    id=password    SuperSecretPassword!
    Click Button    xpath=//button[@class="radius"]
    Wait Until Element Is Visible    id=flash    30s
    ${actual_text}=    Get Text    id=flash
    ${trim_actual_text}=    Get Substring    ${actual_text}    0    -2
    Should Be Equal As Strings    ${trim_actual_text}     You logged into a secure area!
    Click Element    xpath=//a[@href="/logout"]
    Wait Until Element Is Visible    id=flash    30s
    ${actual_text}=    Get Text    id=flash
    ${trim_actual_text}=    Get Substring    ${actual_text}    0    -2
    Should Be Equal As Strings    ${trim_actual_text}     You logged out of the secure area!
    Close Browser

Login failed - Password incorrect
    Open Browser    ${url}    chrome
    Input Text    id=username    tomsmith
    Input Text    id=password    Password!
    Click Button    xpath=//button[@class="radius"]
    Wait Until Element Is Visible    id=flash    30s
    ${actual_text}=    Get Text    id=flash
    ${trim_actual_text}=    Get Substring    ${actual_text}    0    -2
    Should Be Equal As Strings    ${trim_actual_text}     Your password is invalid!
    Close Browser

Login failed - Username incorrect
    Open Browser    ${url}    chrome
    Input Text    id=username    tomholland
    Input Text    id=password    Password!
    Click Button    xpath=//button[@class="radius"]
    Wait Until Element Is Visible    id=flash    30s
    ${actual_text}=    Get Text    id=flash
    ${trim_actual_text}=    Get Substring    ${actual_text}    0    -2
    Should Be Equal As Strings    ${trim_actual_text}     Your username is invalid!
    Close Browser
