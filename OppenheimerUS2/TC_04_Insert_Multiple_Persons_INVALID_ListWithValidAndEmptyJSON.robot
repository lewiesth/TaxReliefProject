*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_04:Insert_Multiple_Persons_INVALID_ListWithValidAndEmptyJSON
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${body1}=    Create Dictionary
    Append To List    ${list}   ${body1}
    ${body2}=    Create Dictionary   birthday=${birthday}    gender=${gender}   name=${name}     natid=${natid}     salary=${salary}     tax=${tax}
    Append To List    ${list}   ${body2}
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session      ${endpoint_insertMultiple}  json=${list}    headers=${header}     expected_status=${status_code_invalid}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    ${status_code_invalid}