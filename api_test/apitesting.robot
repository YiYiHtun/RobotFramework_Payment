*** Settings ***
Library    Collections
Library     RequestsLibrary

*** Variables ***
${base_url}    https://api.restful-api.dev
${id}    1

*** Test Cases ***
Play around with Dictionary
    &{data}=    Create Dictionary    name=rahul    course=robot    website=www.google.com
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name
    Log    ${data}[name]
    ${url}=    Get From Dictionary    ${data}    website
    Log    ${url}
    
    
    
Add Product into Inventory
    [Tags]    API
    &{data}=    Create Dictionary    year=2019     price=1849.99    model=Intel Core i9    hard_disk_size=1 TB
    &{product}=    Create Dictionary    name=YY Apple MacBook Pro 16    data=&{data}
    
    ${response}=    POST    ${base_url}/objects    json=${product}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    name
    ${nested_data}=    Get From Dictionary    ${response.json()}    data
    Log    ${nested_data}
    Log    ${nested_data['year']}
    Log    ${nested_data['price']}
    Should Be Equal    ${nested_data['year']}    2019
    Should Be Equal    ${nested_data['price']}    1849.99
    Should Be Equal    ${nested_data['model']}    Intel Core i9
    Should Be Equal    ${nested_data['hard_disk_size']}    1 TB
    Log    ${response}
    Status Should Be    200    ${response}
    
Get Product Details which specific name
    [Tags]    API
    ${response}=    GET    ${base_url}/objects    params=id=${id}    expected_status=200
    Log    ${response.json()}
    ${list_data}=    Get From List    ${response.json()}    0
    ${product_detail}=    Get From Dictionary    ${list_data}    data

    Should Be Equal As Strings    ${list_data['name']}   Google Pixel 6 Pro


Delete Product from Inventory
     [Tags]      API
     ${delete_response}=    DELETE    ${base_url}/objects/${id}    expected_status=405
     Log    ${delete_response.json()}
     ${error_msg}=    Get From Dictionary    ${delete_response.json()}    error
     Should Be Equal As Strings    ${error_msg}    1 is a reserved id and the data object of it cannot be deleted. You can create your own new object via POST request and try to send a DELETE request with new generated object id.