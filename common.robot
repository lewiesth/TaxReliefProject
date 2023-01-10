*** Variables ***
#Connection and endpoints
${base_url}=    http://localhost:8080
${endpoint_insert}=     /calculator/insert
${endpoint_insertMultiple}=    /calculator/insertMultiple
${endpoint_taxrelief}=  /calculator/taxRelief
${teardown_rake}=   /calculator/rakeDatabase

#Fictitious valid input data
${birthday}=  01012007
${gender}=  M
${name}=    Lewies
${natid}=   s12345678a
${salary}=  10000
${tax}=     1000

${birthday2}=  01012001
${gender2}=  F
${name2}=    TesterA
${natid2}=   s87654321b
${salary2}=  5000
${tax2}=     6000

${birthday3}=  01011985
${gender3}=  F
${name3}=    TesterB
${natid3}=   s12341234e
${salary3}=  14000
${tax3}=     3500

#Payload content type
${content_type_json}=   application/json
${content_type_xml}=    application/xml

#Error messages
${natid_error}=     Natid has failed validation
${taxrelief_error}=    TaxRelief has failed validation
${name_error}=      Name has failed validation

#Status code expected
${status_code_valid}=   202
${status_code_invalid}=     500
${status_code_unsupportedMediaType}=    415

#Browsers to be used
${driver_chrome}=   Chrome
${driver_firefox}=  Firefox
${driver_edge}=     edge
