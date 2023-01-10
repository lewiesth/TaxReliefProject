*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_12:Insert_Single_Person_INVALID_LogicalErrorTaxHigherThanSalary
    [Documentation]     The REST request should be able to identify an anomalous data in that the tax a person paid should not be higher than salary earned
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=${birthday}    gender=${gender}   name=${name}     natid=${natid}     salary=4000     tax=40000
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session    ${endpoint_insert}  json=${body}    headers=${header}     expected_status=${status_code_invalid}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    ${status_code_invalid}