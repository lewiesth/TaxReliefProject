*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     SeleniumLibrary


Test Teardown   Run Keyword     Teardown

*** Variables ***
${base_url}=    http://localhost:8080

*** Keywords ***
Teardown
    POST On Session     session     /calculator/rakeDatabase
    Close Browser

*** Test Cases ***
TC_01:Upload_Files_Via_Chrome
    [Documentation]     The tests in this directory are to validate that the file upload via the website http://localhost:8080/ is able to load the data onto the table properly
    [Tags]  Functional  Portability-C   Smoke
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     Chrome
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:/Users/ECQ1046/PycharmProjects/TaxReliefProject/OppenheimerUS3/TestData/InputDataValid.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[2]/table   timeout=5
    ${rows_count}=  Get Element Count    xpath:/html/body/div/div[2]/div/div[2]/table/tbody/tr

    #Validation
    ${rows_count}=      Convert To String    ${rows_count}
    Should Be Equal    ${rows_count}    10