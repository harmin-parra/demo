*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Browser Library.
Library           Browser

*** Variables ***
${URL}         https://www.selenium.dev/selenium/web/web-form.html
${BROWSER}     firefox
${DELAY}       0


*** Keywords ***
Open Browser To Web Form Page
    New Browser    ${BROWSER}    headless=true
    New Page    ${URL}
    Web form Page Should Be Open

Web form Page Should Be Open
    Get Title    contains    Web form

Set Login
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Text input
    Type Text    ${element}    ${var}

Set Password
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Password
    Type Text    ${element}    ${var}

Set TextArea
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Textarea
    Type Text    ${element}    ${var}

Set Number
    [Arguments]    ${var}
    ${element} =    Get Element    //select[@name='my-select']
    Select Options By    ${element}    Index    ${var}

Set City
    [Arguments]    ${var}
    ${element} =    Get Element    //input[@name='my-datalist']
    Type Text    ${element}    ${var}

Upload File
    [Arguments]    ${var}
    Upload File By Selector    //input[@name='my-file']    ${var}

Set Color
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Color picker
    Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Set Date
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Date picker
    Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Set Range
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Example range
    Fill Text    ${element}    ${var}
    #Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Submit form
    ${element} =    Get Element by Role    BUTTON    name=Submit
    Click    ${element}

Success Page Should Be Open
    Get text    //h1    contains    Form submitted


*** Keywords ***
Ouvrir le navigateur et afficher le formulaire web
    New Browser    ${BROWSER}    headless=true
    New Page    ${URL}
   Le formulaire est affichée

Le formulaire est affichée
    Get Title    contains    Web form

Saisir identifiant
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Text input
    Type Text    ${element}    ${var}

Saisir mot de passe
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Password
    Type Text    ${element}    ${var}

Ecrire paragraphe
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Textarea
    Type Text    ${element}    ${var}

Sélectionner le nombre
    [Arguments]    ${var}
    ${element} =    Get Element    //select[@name='my-select']
    Select Options By    ${element}    Index    ${var}

Sélectionner la ville
    [Arguments]    ${var}
    ${element} =    Get Element    //input[@name='my-datalist']
    Type Text    ${element}    ${var}

Charger le fichier
    [Arguments]    ${var}
    Upload File By Selector    //input[@name='my-file']    ${var}

Choisir la coleur
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Color picker
    Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Sélectionner la date
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Date picker
    Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Sélectionner range
    [Arguments]    ${var}
    ${element} =    Get Element by    Label    Example range
    Fill Text    ${element}    ${var}
    #Evaluate JavaScript    ${element}    (elem, arg) => { elem.value = arg; }    arg=${var}

Envoyer le formulaire
    ${element} =    Get Element by Role    BUTTON    name=Submit
    Click    ${element}

La page de confimation est affichée
    Get text    //h1    contains    Form submitted
