*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Resource   resources/keywords.robot
Suite Setup    Open Browser To Payment Page
Suite Teardown    Close Browser

*** Variables ***
${BASE_URL}        file:///D:/RobotFramework/ui/payment_ui.html
${MOCK_API_URL}    http://localhost:3000/mock-payment
${success_code}    200
${server_error}    500
${insufficient}    400
${refund}    301
${authentication_fail}    401


*** Test Cases ***
#Verify successful test processing with valid card
Successful Payment Flow
    [Tags]    payment    happy-path
    Fill Payment Form    4111111111111111    12/28    123    100
    Submit Payment
    Mock Payment Gateway    200    {"status":"success","transaction_id":"123ABC","remark":"Payment Successful"}    ${success_code}
    Verify Payment Success
    Clear Payment Status

#Validate error on invalid card details
Invalid Payment Flow
    [Tags]    payment    error-path
    Fill Payment Form    123333333333    12/20    123    1000
    Submit Payment
    Mock Payment Gateway    401    {"status": "error","message": "Invalid Credit Card","detail": "Authentication fail "}    ${authentication_fail}
    Verify Refund Process
    Clear Payment Status

#Submit test when test service is down
Payment Gateway Down
    [Tags]    payment    error-path
    Fill Payment Form    4111111111111145    12/28    123    1000
    Submit Payment
    Mock Payment Gateway    500    {"status": "error","message": "Internal Server Error","detail": "Unexpected server failure while processing payment"}    ${server_error}
    Verify Refund Process
    Clear Payment Status

#Verify refund processed correctly
Verify Refund Payment
    [Tags]    payment    error-path
    Fill Payment Form    4111111111111145    12/28    123    1300
    Submit Payment
    Mock Payment Gateway    301    {"status": "error","message": "Unexpect error happened","detail": "Payment will refund soon"}    ${refund}
    Verify Refund Process
    Clear Payment Status


Failed Payment Flow
    [Tags]    payment    error-path
    Fill Payment Form    4111111111111145    12/28    123    100
    Submit Payment
    Mock Payment Gateway    400    {"status":"failed","error":"Insufficient funds","remark":"Payment Fail"}    ${insufficient}
    Verify Payment Failure
