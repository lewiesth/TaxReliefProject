*** Settings ***
Library     RequestsLibrary
Library     Collections

Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080


*** Test Cases ***
TC_03:Insert_Single_Person_INVALID_InvalidDataEnum
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=17061995    gender=Male   name=Lewies     natid=s9520789h     salary=4000     tax=300
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insert  json=${body}    headers=${header}    expected_status=500

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500