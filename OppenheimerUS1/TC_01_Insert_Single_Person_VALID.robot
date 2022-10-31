*** Settings ***
Library     RequestsLibrary
Library     Collections

Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080


*** Test Cases ***
TC_01:Insert_Single_Person_VALID
    [Documentation]     The tests in this directory are for testing the POST request http://localhost:8080/calculator/insert for both valid and invalid input data
    [Tags]  Functional  Smoke
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=17061995    gender=M   name=Lewies     natid=s9520789h     salary=4000     tax=300
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insert  json=${body}    headers=${header}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    Alright
    Should Be Equal    ${status_code}    202