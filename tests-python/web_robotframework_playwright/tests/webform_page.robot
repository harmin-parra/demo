*** Settings ***
Documentation     Testing the fill-in and submit of a web form.

Resource          ../keywords/webform.robot
Library     AllureLibrary
Library     OperatingSystem


*** Test Cases ***
test_fill_in_form_en
    [TAGS]
    ...  allure.label.epic:Web interface (Robot Framework)
    #...  allure.label.parentSuite:Web interface (Robot Framework)
    #...  allure.label.suite:Web Form
    ...  allure.label.story:Web Form
    ...  allure.label.package:web_robotframework.webform_test
    ...  allure.label.testMethod:test_fill_in_form
    Open Browser To Web Form Page
    Take Screenshot   EMBED    fullPage=True
    Set Login    login
    Set Password    password
    Set TextArea    Hello, World!
    Set Number    2
    Set City    Los Angeles
    Upload File    /tmp/test/file.xml
    Set Color    \#00FF00
    Set Date    01/01/2024
    Set Range    1
    Take Screenshot   EMBED    fullPage=True
    Log File    /tmp/test/file.xml
    Submit Form
    Take Screenshot   EMBED    fullPage=True
    Success Page Should Be Open


*** Test Cases ***
test_fill_in_form_fr
    [TAGS]
    ...  allure.label.epic:Web interface (Robot Framework)
    #...  allure.label.parentSuite:Web interface (Robot Framework)
    #...  allure.label.suite:Web Form
    ...  allure.label.story:Web Form
    ...  allure.label.package:web_robotframework.webform_test
    ...  allure.label.testMethod:test_fill_in_form
    Ouvrir le navigateur et afficher le formulaire web
    Take Screenshot   EMBED    fullPage=True
    Saisir identifiant    login
    Saisir mot de passe    password
    Ecrire paragraphe    Hello, World!
    Sélectionner le nombre    2
    Sélectionner la ville    Los Angeles
    Charger le fichier    /tmp/test/file.xml
    Choisir la coleur    \#00FF00
    Sélectionner la date    01/01/2024
    Sélectionner range    1
    Take Screenshot   EMBED    fullPage=True
    Log File    /tmp/test/file.xml
    Envoyer le formulaire
    Take Screenshot   EMBED    fullPage=True
    La page de confimation est affichée
