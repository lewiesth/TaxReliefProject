*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     String

Test Teardown   POST On Session     session     /calculator/rakeDatabase

*** Variables ***
${base_url}=    http://localhost:8080
${endpoint}=    /calculator/insertMultiple
${endpoint_taxrelief}=  /calculator/taxRelief
${teardown_rake}=   /calculator/rakeDatabase

${birthday}=  01012007
${gender}=  M
${name}=    Lewies
${natid}=   s1234567a
${salary}=  10000
#${tax}=     1000
${natid_error}=     Natid has failed validation
${taxrelief_error}=    TaxRelief has failed validation
${name_error}=      Name has failed validation

${status_code_valid}=   202
${status_code_invalid}=     500

*** Keywords ***
Decimal Rounding
    [Arguments]     ${Comment}     ${birthday}      ${gender}   ${name}     ${natid}    ${salary}   ${tax}      ${Expected_status_code}
    Create Session    session    ${base_url}
    ${list}=    Create List
    ${list2}=   Create List
    ${body1}=    Create Dictionary   birthday=${birthday}     gender=${gender}   name=${name}      natid=${natid}     salary=${salary}     tax=${tax}
    Append To List    ${list}   ${body1}

    Calculate Tax Relief    ${list}     ${list2}

    ${header}=      Create Dictionary   Content-Type=application/json
    ${response}=    POST On Session    session    ${endpoint}  json=${list}    headers=${header}
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal    ${status_code}    ${Expected_Status_Code}    msg=Invalid status code. Expected ${Expected_Status_Code}

    ${response_taxrelief}=      Get On Session     session     ${endpoint_taxrelief}

    POST On Session     session     ${teardown_rake}

    Masking Natid and Validation    ${list2}    ${response_taxrelief}

Calculate Tax Relief
    [Arguments]     ${listOfTaxpayers}      ${secondList}
    FOR     ${item}     IN      @{listOfTaxpayers}
        ${item_salary}=      Get From Dictionary     ${item}     salary
        ${item_tax}=        Get From Dictionary     ${item}     tax
        ${item_birthday}=        Get From Dictionary     ${item}     birthday
        ${item_gender}=     Get From Dictionary     ${item}     gender
        ${item_name}=   Get From Dictionary     ${item}     name
        ${item_natid}=      Get From Dictionary     ${item}     natid

        ${item_birthyear}=      Get Substring   ${item_birthday}    -4
        ${item_age}=        Evaluate    2022-${item_birthyear}

        IF  "${item_gender}"=="M"
            ${gender_bonus}=    Set Variable    0
        ELSE IF  "${item_gender}"=="F"
            ${gender_bonus}=    Set Variable    500
        END

        IF  ${item_age}<=18
            ${age_variable}=    Set Variable    1
        ELSE IF  ${item_age}>18 and ${item_age}<=35
            ${age_variable}=    Set Variable    0.8
        ELSE IF  ${item_age}>35 and ${item_age}<=50
            ${age_variable}=    Set Variable    0.5
        ELSE IF  ${item_age}>50 and ${item_age}<=75
            ${age_variable}=    Set Variable    0.367
        ELSE IF  ${item_age}>75
            ${age_variable}=    Set Variable    0.05
        END

        ${Tax_Relief}=      Evaluate    int((((${item_salary}-${item_tax})*${age_variable})+${gender_bonus})*100)/100.0
        ${Tax_Relief}=      Evaluate    "%.2f" %round(${Tax_Relief})

        IF  ${Tax_Relief}>0 and ${Tax_Relief}<50
            ${Tax_Relief}=  Set Variable    50
        END

        ${body_list2}=  Create Dictionary   name=${item_name}   natid=${item_natid}     tax_relief=${Tax_Relief}
        Append To List  ${secondList}    ${body_list2}
    END

Masking Natid and Validation
    [Arguments]     ${ListOfTaxrelief}      ${responsebody}
    FOR     ${item2}     IN      @{ListOfTaxrelief}
        ${item2_name}=   Get From Dictionary     ${item2}     name
        ${item2_taxrelief}=   Get From Dictionary     ${item2}     tax_relief
        ${item2_natid}=   Get From Dictionary     ${item2}     natid

        ${natid_length}=    Get Length    ${item2_natid}
        ${visible_natid}=   Get Substring    ${item2_natid}    0    4
        ${length_to_hide}=  Evaluate    ${natid_length}-4
        ${hidden_characters}=   Set Variable    ${EMPTY}
        FOR     ${i}    IN RANGE    ${length_to_hide}
            ${hidden_characters}    Catenate    SEPARATOR=  ${hidden_characters}    $
        END
        ${hidden_natid}=    Catenate    SEPARATOR=  ${visible_natid}    ${hidden_characters}

        ${item2_taxrelief_string}=  Convert To String    ${item2_taxrelief}

        ${responsebody_contents}=    Evaluate    json.loads('''${responsebody.content}''')    json
        ${responsebody_content}=     Copy Dictionary    ${responsebody_contents}[0]

        Should Be Equal    ${responsebody_content}[natid]    ${hidden_natid}    msg=${natid_error}
        Should Be Equal    ${responsebody_content}[relief]     ${item2_taxrelief_string}     msg=${taxrelief_error}
        Should Be Equal    ${responsebody_content}[name]     ${item2_name}     msg=${name_error}
    END

*** Test Cases ***
Tax Relief Formula Decimal Rounding
    [Template]  Decimal Rounding
    --Testing for relief with decimal .00   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9900     ${status_code_valid}
    --Testing for relief with decimal .01   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.99     ${status_code_valid}
    --Testing for relief with decimal .26   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.74     ${status_code_valid}
    --Testing for relief with decimal .49   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.51     ${status_code_valid}
    --Testing for relief with decimal .50   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.5     ${status_code_valid}
    --Testing for relief with decimal .51   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.49     ${status_code_valid}
    --Testing for relief with decimal .74   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.26     ${status_code_valid}
    --Testing for relief with decimal .99   ${birthday}    ${gender}      ${name}    ${natid}   ${salary}  9899.01     ${status_code_valid}


