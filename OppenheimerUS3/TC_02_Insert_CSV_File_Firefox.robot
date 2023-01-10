*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     SeleniumLibrary
Resource    ${CURDIR}/../common.robot

Test Teardown   Run Keyword     Teardown

*** Keywords ***
Teardown
    POST On Session     session     ${teardown_rake}
    Close Browser

*** Test Cases ***
TC_02:Upload_Files_Via_Firefox
    [Tags]  Functional  Portability-FF   Smoke
    Create Session    session    ${base_url}
    Open Browser    ${base_url}         ${driver_firefox}
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:\\Users\\ECQ1046\\PycharmProjects\\TaxReliefProject\\OppenheimerUS3\\TestData\\InputDataValid.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[2]/table   timeout=5
    ${rows_count}=  Get Element Count    xpath:/html/body/div/div[2]/div/div[2]/table/tbody/tr

    #Validation
    ${rows_count}=      Convert To String    ${rows_count}
    Should Be Equal    ${rows_count}    10
