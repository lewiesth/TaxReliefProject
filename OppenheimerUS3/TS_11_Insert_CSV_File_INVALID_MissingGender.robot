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
TC_11_1:Upload_Files_INVALID_MissingGenderChrome
    [Tags]  Functional  Portability-C
    Create Session    session    ${base_url}
    Open Browser    ${base_url}     ${driver_chrome}
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:/Users/ECQ1046/PycharmProjects/TaxReliefProject/OppenheimerUS3/TestData/InputDataInvalidMissingGender.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment

TC_11_2:Upload_Files_INVALID_MissingGenderFirefox
    [Tags]  Functional  Portability-FF
    Create Session    session    ${base_url}
    Open Browser    ${base_url}     ${driver_firefox}
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:\\Users\\ECQ1046\\PycharmProjects\\TaxReliefProject\\OppenheimerUS3\\TestData\\InputDataInvalidMissingGender.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment

TC_11_3:Upload_Files_INVALID_MissingGenderEdge
    [Tags]  Functional  Portability-E
    Create Session    session    ${base_url}
    Open Browser    ${base_url}     ${driver_edge}
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:/Users/ECQ1046/PycharmProjects/TaxReliefProject/OppenheimerUS3/TestData/InputDataInvalidMissingGender.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment