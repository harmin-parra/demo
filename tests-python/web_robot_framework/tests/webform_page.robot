*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../keywords/webform.robot

*** Test Cases ***
Fill in and Submit web form
    Open Browser To Web Form Page
    Set Login    login
    Set Password    password
    Set TextArea    Hello, World!
    Set Number    2
    Set City    Los Angeles
    Set Color    \#00FF00
    Set Date    01/01/2024
    [Teardown]    Close Browser
