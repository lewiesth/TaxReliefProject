*** Settings ***
Library     RequestsLibrary
Library     Collections

Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080


*** Test Cases ***
TC_14:Insert_Single_Person_INVALID_LogicalErrorNatidAlreadyExists
    [Documentation]     The REST request should be able to identify that a particular record already exists in the table, ideally using natid. It should then throw a warning or refuse the request
    [Tags]  Functional  Logical
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=17061995    gender=M   name=Lewies     natid=s9520789h     salary=4000     tax=300
    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    /calculator/insert  json=${body}    headers=${header}
    ${response2}=    POST On Session    session    /calculator/insert  json=${body}    headers=${header}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    500