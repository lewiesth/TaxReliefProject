*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     SeleniumLibrary
Library    String
Library    XML


Test Teardown   Run Keyword     Teardown

*** Variables ***
${base_url}=    http://localhost:8080

*** Keywords ***
Teardown
    POST On Session     session     /calculator/rakeDatabase
    Close Browser

*** Test Cases ***
TC_03_01:Dispense_Button_CheckColorEdge
    [Tags]  Functional  Smoke   Portability-E
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     edge
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/a[2]      timeout=5
    ${button_element}=  Get WebElement   xpath=/html/body/div/div[2]/div/a[2]
    ${button_color}=    Call Method    ${button_element}    value_of_css_property   background-color
    ${button_string}=     Convert To String    ${button_color}
    ${button_string}=   Get Substring   ${button_string}    5
    ${button_string}=   Get Substring   ${button_string}    0   -1
    ${rgb_list}=    Split String    ${button_string}    ,
    ${color_r}=    Get From List    ${rgb_list}    0
    ${color_g}=    Get From List    ${rgb_list}    1
    ${color_b}=    Get From List    ${rgb_list}    2

    Should Be True    (${color_r}<=255 and ${color_r}>=160) and (${color_b}<=75 and ${color_b}>=0) and (${color_g}<=75 and ${color_g}>=0)

TC_03_02:Dispense_Button_CheckTextEdge
    [Tags]  Functional  Smoke   Portability-E
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     edge
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/a[2]      timeout=5
    ${button_element}=  Get WebElement   xpath=/html/body/div/div[2]/div/a[2]
    ${button_element_text}=     Set Variable    ${button_element.text}
    Should Be Equal    ${button_element_text}    Dispense Now

TC_03_03:Dispense_Button_ClickAndDivertEdge
    [Tags]  Functional  Smoke   Portability-E
    Create Session    session    ${base_url}
    Open Browser    http://localhost:8080/     edge
    Wait Until Element Is Visible    xpath:/html/body/div/div[2]/div/a[2]      timeout=5
    Click Element    xpath:/html/body/div/div[2]/div/a[2]
    Wait Until Element Is Visible    xpath:/html/body/div/div/div/main/div/div/div  timeout=5
    ${text_element}=    Get WebElement    xpath:/html/body/div/div/div/main/div/div/div
    ${text_element_text}=   Set Variable    ${text_element.text}
    Should Be Equal    ${text_element_text}    Cash dispensed