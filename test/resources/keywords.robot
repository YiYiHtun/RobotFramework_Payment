*** Keywords ***
Open Browser To Payment Page
    Open Browser    ${BASE_URL}    Chrome
    Maximize Browser Window

Fill Payment Form
    [Arguments]    ${card_number}    ${expiry_date}    ${cvv}    ${amount}
    Input Text    id=card_number    ${card_number}
    Input Text    id=expiry_date    ${expiry_date}
    Input Text    id=cvv    ${cvv}
    Input Text    id=amount    ${amount}

Submit Payment
    Click Button    id=submit-payment
    Sleep    2s


Mock Payment Gateway
    [Arguments]    ${status_code}    ${response_body}    ${expected_status}
    Create Session    mock    ${MOCK_API_URL}
    ${response}=    POST On Session    mock    /process    json=${response_body}
    Should Be Equal As Integers    ${expected_status}    ${status_code}
    #disply mock api response
    Input Text    id=status     ${status_code}
    Input Text    id=tran_details    ${response_body}
    Sleep    1s
     IF    '${status_code}' == '${success_code}'
        ${message}=    Set Variable    Payment successful
        
     ELSE IF    '${status_code}' == '${authentication_fail}'
        ${message}=    Set Variable    Authentication fail
     
     ELSE IF    '${status_code}' == '${server_error}'
        ${message}=    Set Variable    Internal Server Error   

     ELSE IF    '${status_code}' == '${insufficient}'
        ${message}=    Set Variable    Insufficient Amount and unable to proceed payment

     ELSE IF    '${status_code}' == '${refund}'
        ${message}=    Set Variable    Unexpected error happened and Payment will refund soon
    ELSE
        ${message}=    Set Variable    Payment failed
    END
    Input Text    id=payment_status    ${message}
    Sleep    2s


Verify Payment Success
    Log    Payment Successful
    #to write other verify steps for receipt email

Verify Payment Failure
    Log    Payment Failure
     #to write other verify steps for retry steps

Verify Refund Process
    Log   Proceed to Refund Process
    #to write other verify steps for refund test case

Verify Invalid Credit Card
    Log   Show Invalid Credit Cart

Verify PaymentGateway Down
    Log    Payment Gateway Down:unable to connect


Clear Payment Status
    Clear Element Text    id=status
    Clear Element Text    id=tran_details
    Clear Element Text    id=payment_status