*** Settings ***
Library             SeleniumLibrary 
Test Setup          Open Web browser
Test Teardown       Close Browser

*** Variables ***
${url}                 https://www.codium.co/
${browser}             gc
${cookie}              xpath=//*[@id="accept-button"]
${product_services}    xpath=//*[@id="__next"]/div/div[1]/div/div/div[2]/div
${e-tax_invoice}       xpath=//*[@id="__next"]/div/div[2]/div/div/a[4]
${scroll_calculate}    xpath=//*[@id="__next"]/main/div[2]/div[14]/div/div[3]/div[3]
${select_tax}          xpath=//*[@id="__next"]/main/div[2]/div[14]/div/div[1]/div/select
${paper_tax}           xpath=//*[@id="__next"]/main/div[2]/div[14]/div/div[2]/div[1]/div/div[6]/div[2]
${tax_invoice}         xpath=//*[@id="__next"]/main/div[2]/div[14]/div/div[2]/div[2]/div/div[6]/div[2]
${newsfeed}            xpath=//*[@id="__next"]/div/div/div/div/div[4]/div
${Resources}           xpath=//*[@id="__next"]/div/div[2]/div/div/a[2]
${search}              xpath=//*[@id="__next"]/main/div/div[4]/input
${ememo}               xpath=//*[@id="__next"]/main/div/div[5]/div/ul/li[1]/div/div[2]

*** Keywords ***
Open Web Browser
    Set Selenium Speed                   0.5s
    Open Browser                         ${url}    ${browser}
    Maximize Browser Window

Check Data Product Services
    Wait Until Page Contains             Contract. Transformed.
    Click Element                        ${cookie}
    Click Element                        ${product_services}
    Wait Until Element Is Visible        ${e-tax_invoice}
    Click Element                        ${e-tax_invoice}
    Wait Until Page Contains             E-TAX INVOICE & RECEIPT
    Scroll Element Into View             ${scroll_calculate}
    Wait Until Page Contains             CALCULATE
    Wait Until Element Is Visible        ${select_tax}
    Select From List By Value            ${select_tax}    100000

Check Data Service Fee
    Wait Until Element Is Visible        ${paper_tax}
    ${service_tax}=    Get Text          ${paper_tax}
    Log To Console                       Service Tax:${service_tax}  
    Should Be Equal As Strings           ${service_tax}    2,202,000 ฿

    Wait Until Element Is Visible        ${tax_invoice}
    ${e_tax_invoice}=    Get Text        ${tax_invoice}
    Log To Console                       E-Tax Invoice: ${e_tax_invoice}
    Should Be Equal As Strings           ${e_tax_invoice}    95,000฿

Check Data News Feed
    Wait Until Page Contains             Contract. Transformed.
    Wait Until Element Is Visible        ${cookie}
    Click Element                        ${cookie}
    Wait Until Element Is Visible        ${newsfeed}
    Click Element                        ${newsfeed}
    Wait Until Element Is Visible        ${Resources}
    Click Element                        ${Resources}
    Input Text                           ${search}    e-Memo

Check Data Topic
    Wait Until Element Is Visible        ${ememo}
    ${e-Memo}=    Get Text               ${ememo}
    Log To Console                       e-Memo: ${e-Memo}
    Should Be Equal As Strings           ${e-Memo}     e-Memo ระบบลงลายมือชื่ออิเล็กทรอนิกส์

*** Test Cases ***
TC-1 e-Tax Product
    [Documentation]    ใช้สำหรับทดสอบกรณีเลือกข้อมูล และตรวจสอบข้อมูล
    [Tags]    Product
    Check Data Product Services
    Check Data Service Fee

TC-2 Resource 
    [Documentation]    ใช้สำหรับทดสอบกรณีกรอกข้อมูล และตรวจสอบข้อมูล
    [Tags]    Search
    Check Data News Feed
    Check Data Topic
