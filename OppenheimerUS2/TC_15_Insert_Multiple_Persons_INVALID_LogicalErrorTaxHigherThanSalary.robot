*** Settings ***
Library     RequestsLibrary
Library     Collections


Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080

*** Test Cases ***
TC_15:Insert_Multiple_Persons_INVALID_LogicalErrorTaxHigherThanSalary
    [Documentation]     The REST request should be able to identify an anomalous data in that the tax a person paid should not be higher than salary earned
    [Tags]  Functional  Logical
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${body1}=    Create Dictionary   birthday=17061995    gender=M   name=Lewies     natid=s12345678h     salary=4000     tax=40000
    Append To List    ${list}   ${body1}
    ${body2}=    Create Dictionary   birthday=04071997    gender=F   name=TesterB     natid=s87654321a     salary=3000     tax=25000
    Append To List    ${list}   ${body2}
    ${body3}=    Create Dictionary   birthday=01011960    gender=F   name=TesterC     natid=s11223344d     salary=8000     tax=200000
    Append To List    ${list}   ${body3}
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insertMultiple  json=${list}    headers=${header}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500