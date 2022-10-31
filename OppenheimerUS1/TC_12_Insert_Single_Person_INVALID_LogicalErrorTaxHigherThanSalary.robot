*** Settings ***
Library     RequestsLibrary
Library     Collections

Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080


*** Test Cases ***
TC_12:Insert_Single_Person_INVALID_LogicalErrorTaxHigherThanSalary
    [Documentation]     The REST request should be able to identify an anomalous data in that the tax a person paid should not be higher than salary earned
    [Tags]  Functional  Logical
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=17061995    gender=M   name=Lewies     natid=s9520789h     salary=4000     tax=40000
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insert  json=${body}    headers=${header}     expected_status=500

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500