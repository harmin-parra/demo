*** Settings ***
Documentation     Testing the fill-in and submit of a web form.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../keywords/webform.robot
Library           OperatingSystem

*** Test Cases ***
test_fill_in_form_en
    Open Browser To Web Form Page
    Capture Page Screenshot    EMBED
    Set Login    login
    Set Password    password
    Set TextArea    Hello, World!
    Set Number    2
    Set City    Los Angeles
    Upload File    /tmp/test/file.xml
    Set Color    \#00FF00
    Set Date    01/01/2024
    Set Range    1
    Capture Page Screenshot    EMBED
    Log File    /tmp/test/file.xml
    Submit Form
    Capture Page Screenshot    EMBED
    [Teardown]    Close Browser
