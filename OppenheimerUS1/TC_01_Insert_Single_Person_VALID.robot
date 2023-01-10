*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ${CURDIR}/../common.robot

Test Teardown   POST On Session     session     ${teardown_rake}

*** Test Cases ***
TC_01:Insert_Single_Person_VALID
    [Documentation]     The tests in this directory are for testing the POST request http://localhost:8080/calculator/insert for both valid and invalid input data
    [Tags]  Functional  Smoke
    Create Session    session    ${base_url}
    ${body}=    Create Dictionary   birthday=${birthday}    gender=${gender}   name=${name}     natid=${natid}     salary=${salary}     tax=${tax}
    ${header}=      Create Dictionary   Content-Type=${content_type_json}
    ${response}=    POST On Session    session    ${endpoint_insert}  json=${body}    headers=${header}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    Alright
    Should Be Equal    ${status_code}    ${status_code_valid}