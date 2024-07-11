*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Browser Library.
Library           Browser

*** Variables ***
${URL}         http://harmin-demo.gitlab.io/reports/web/ajax.html
${BROWSER}     firefox
${DELAY}       0


*** Keywords ***
Open Browser To Ajax Page
    New Browser    ${BROWSER}    headless=true
    New Page    ${URL}
    # Ajax Page Should Be Open

Ajax Should Be Open
    Get Title    contains    Ajax page

Click Button
    ${element} =    Get Element    \#button
    Click    \#button

Wait Ajax Response
    Wait For Response   **/ajax.txt

Verify Ajax Response
    Get text    \#title    contains    AJAX
