*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${URL}         https://www.selenium.dev/selenium/web/web-form.html
${BROWSER}     headlessfirefox
${DELAY}       0


*** Keywords ***
Open Browser To Web Form Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Web form Page Should Be Open

Web form Page Should Be Open
    Title Should Be    Web form

Set Login
    [Arguments]    ${var}
    Input Text    my-text    ${var}

Set Password
    [Arguments]    ${var}
    Input Text    my-password    ${var}

Set TextArea
    [Arguments]    ${var}
    Input Text    my-textarea    ${var}

Set Number
    [Arguments]    ${var}
    Select From List By Index    my-select    ${var}

Set City
    [Arguments]    ${var}
    Input Text    my-datalist    ${var}
    Click Element   //body

Set Color
    [Arguments]    ${var}
    Execute Javascript    document.getElementsByName('my-colors')[0].value = arguments[0]    ARGUMENTS    ${var}

Set Date
    [Arguments]    ${var}
    Input Text    my-date    ${var}
    Click Element   //body

Submit form
    Click Button    //button[@type='submit']

Success Page Should Be Open
    Page Should Contain    Form submitted
