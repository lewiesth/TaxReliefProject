*** Settings ***
Library     RequestsLibrary
Library     Collections


Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080

*** Test Cases ***
TC_04:Insert_Multiple_Persons_INVALID_ListWithValidAndEmptyJSON
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${body1}=    Create Dictionary
    Append To List    ${list}   ${body1}
    ${body2}=    Create Dictionary   birthday=04071997    gender=F   name=TesterB     natid=s87654321a     salary=3000     tax=250
    Append To List    ${list}   ${body2}
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insertMultiple  json=${list}    headers=${header}     expected_status=500

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500