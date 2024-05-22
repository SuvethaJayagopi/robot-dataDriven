*** Settings ***
Documentation    to validate login form
Library    SeleniumLibrary
Library    DataDriver    file=../TestData/LoginData.xlsx   sheet-name=login
Test Template    validate unsuccessful Login

*** Variables ***
${browser}    Chrome
${login_btn}    css:.orangehrm-login-button
${login_error_message}    css:.oxd-alert-content--error

*** Test Cases ***
Login to form using    ${username}    ${password}

*** Keywords ***
validate unsuccessful login
    [Arguments]    ${username}    ${password}
    Open the browser with url
    Fill the login form    ${username}    ${password}
    verify the error message is correct

Open the browser with url
    Create Webdriver    ${browser}
    Go To    url=https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    Maximize Browser Window
    Set Selenium Implicit Wait    5

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    name:username    ${username}
    Input Password    name:password    ${password}
    Click Button    ${login_btn}

verify the error message is correct
    ${result}=    Get Text    ${login_error_message}
    Should Be Equal As Strings    ${result}    Invalid credentials

close browser session
    Close Browser