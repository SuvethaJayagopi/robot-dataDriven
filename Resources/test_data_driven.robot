*** Settings ***
Documentation    data driven 
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Template    Validate unsuccessful login

*** Variables ***
${browser}    Chrome
${login_btn}    css:.orangehrm-login-button
${login_error_message}    css:.oxd-alert-content--error

*** Test Cases ***                  username             password
Invalid username                    abc                  admin123
Invalid password                    Admin                abc
Special characters                  @=$                  %^&*$#
Invalid username and password       abc                  abc123

*** Keywords ***
validate unsuccessful login
    [Arguments]    ${username}    ${password}
    Open the browser with url
    Fill the login form    ${username}    ${password}
    verify the error message is correct
    close browser session

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


        
