*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_14:Insert_Single_Person_INVALID_LogicalErrorNatidAlreadyExists
    [Documentation]     The REST request should be able to identify that a particular record already exists in the table, ideally using natid. It should then throw a warning or refuse the request
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=${birthday}    gender=${gender}   name=${name}     natid=${natid}     salary=${salary}     tax=${tax}
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session    ${endpoint_insert}  json=${body}    headers=${header}
    ${response2}=    POST On Session    session    ${endpoint_insert}   json=${body}    headers=${header}        expected_status=${status_code_invalid}

    #Validations
    ${status_code}=     convert to string   ${response2.status_code}
    Should Be Equal    ${status_code}    ${status_code_invalid}