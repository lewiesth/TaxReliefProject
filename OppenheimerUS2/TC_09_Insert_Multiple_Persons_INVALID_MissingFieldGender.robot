*** Settings ***
Library     RequestsLibrary
Library     Collections


Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080

*** Test Cases ***
TC_09:Insert_Multiple_Persons_INVALID_MissingFieldGender
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${body1}=    Create Dictionary   birthday=17061995    name=Lewies     natid=s12345678h     salary=4000     tax=400
    Append To List    ${list}   ${body1}
    ${body2}=    Create Dictionary   birthday=04071997    gender=F   name=TesterB     natid=s87654321a     salary=3000     tax=250
    Append To List    ${list}   ${body2}
    ${body3}=    Create Dictionary   birthday=01011960    gender=F   name=TesterC     natid=s11223344d     salary=8000     tax=2000
    Append To List    ${list}   ${body3}
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insertMultiple  json=${list}    headers=${header}     expected_status=500

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500