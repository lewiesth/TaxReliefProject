*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_05:Insert_Multiple_Persons_INVALID_InvalidDataEnum
    [Tags]  Functional
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${body1}=    Create Dictionary   birthday=${birthday}    gender=Male   name=${name}     natid=${natid}     salary=${salary}     tax=${tax}
    Append To List    ${list}   ${body1}
    ${body2}=    Create Dictionary   birthday=${birthday2}    gender=${gender2}   name=${name2}     natid=${natid2}     salary=${salary2}     tax=${tax2}
    Append To List    ${list}   ${body2}
    ${body3}=    Create Dictionary   birthday=${birthday3}    gender=${gender3}   name=${name3}     natid=${natid3}     salary=${salary3}     tax=${tax3}
    Append To List    ${list}   ${body3}
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session    ${endpoint_insertMultiple}  json=${list}    headers=${header}     expected_status=${status_code_invalid}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    ${status_code_invalid}