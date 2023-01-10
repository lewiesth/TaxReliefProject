*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_15:Insert_Single_Person_INVALID_LogicalErrorBirthdateInFuture
    [Documentation]     The REST request should be able to identify invalid birthdates such as those in the future or in very recent years
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=17062030    gender=${gender}   name=${name}     natid=${natid}     salary=${salary}     tax=${tax}
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session    ${endpoint_insert}  json=${body}    headers=${header}    expected_status=${status_code_invalid}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    ${status_code_invalid}