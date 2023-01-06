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
TC_17_1:Upload_Files_INVALID_TaxGreaterThanSalaryChrome
    [Tags]  Functional  Portability-C
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     Chrome
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:/Users/ECQ1046/PycharmProjects/TaxReliefProject/OppenheimerUS3/TestData/InputDataInvalidTaxGreaterThanSalary.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment

TC_17_2:Upload_Files_INVALID_TaxGreaterThanSalaryFirefox
    [Tags]  Functional  Portability-FF
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     Firefox
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:\\Users\\ECQ1046\\PycharmProjects\\TaxReliefProject\\OppenheimerUS3\\TestData\\InputDataInvalidTaxGreaterThanSalary.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment

TC_17_3:Upload_Files_INVALID_TaxGreaterThanSalaryEdge
    [Tags]  Functional  Portability-E
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     edge
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/div[1]/div[2]      timeout=5
    Choose File    xpath:/html/body/div/div[2]/div/div[1]/div[2]/input    C:/Users/ECQ1046/PycharmProjects/TaxReliefProject/OppenheimerUS3/TestData/InputDataInvalidTaxGreaterThanSalary.csv
    Click Button    xpath:/html/body/div/div[2]/div/button[1]
    ${No_Records_Message}=      Get Text     xpath:/html/body/div/div[2]/div/h1

    #Validation
    Should Contain      ${No_Records_Message}       No records at the moment