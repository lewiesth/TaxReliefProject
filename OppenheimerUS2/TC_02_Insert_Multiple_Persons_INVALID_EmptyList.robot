*** Settings ***
Library     RequestsLibrary
Library     Collections


Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080

*** Test Cases ***
TC_02:Insert_Multiple_Persons_INVALID_EmptyList
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insertMultiple  json=${list}    headers=${header}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500