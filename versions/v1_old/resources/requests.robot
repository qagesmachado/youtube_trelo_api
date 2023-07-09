*** Settings ***
Library    RequestsLibrary
Library    Collections
Library           OperatingSystem
Library           String
Resource   ../resources/auth.robot
Resource   ../resources/requests.robot

*** Variables ***


*** Keywords ***
Creating Session
  [arguments]  ${alias}  ${url}
  Create Session      alias=${alias}    url=${url}
  Set Global Variable    ${alias}

# GET
Get All Board
  [arguments]   ${api_key}  ${token_trello}

  ${response_patch_request}     Get Request    ${alias}    /1/members/me/boards?key=${api_key}&token=${token_trello}

  Validate Response Status Code    ${response_patch_request.status_code}    200

Get Board Id By board Name
  [arguments]   ${api_key}  ${token_trello}  ${board_name}

  ${response_patch_request}     Get Request    ${alias}    /1/members/me/boards?key=${my_api_key}&token=${token_trello}

  Validate Response Status Code    ${response_patch_request.status_code}    200

  ${board_id}  Get ID by string name  ${response_patch_request}  ${board_name}

  [return]  ${board_id}

Get Id List on a Board
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name}

  ${board_id}  Get Board Id By board Name    ${api_key}  ${token_trello}  ${board_name}

  ${response_patch_request}     Get Request    ${alias}    /1/boards/${board_id}/lists?key=${my_api_key}&token=${token_trello}
  Validate Response Status Code    ${response_patch_request.status_code}    200

  ${list_id}  Get ID by string name  ${response_patch_request}  ${list_name}

  [return]  ${list_id}

Get Card Id in a List
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name}  ${card_name}

  ${list_id}  Get Id List on a Board    ${api_key}  ${token_trello}  ${board_name}  ${list_name}

  ${response_patch_request}     Get Request    ${alias}    /1/list/${list_id}/cards?key=${my_api_key}&token=${token_trello}
  Validate Response Status Code    ${response_patch_request.status_code}    200

  ${card_id}  Get ID by string name  ${response_patch_request}  ${card_name}

  [return]  ${card_id}

Get ID by string name
  [arguments]   ${response_patch_request}  ${string_name}

  ${response_json}   Convert To String    ${response_patch_request.json()}
  ${result}   Get Count    ${response_json}    'name':

  FOR  ${i}  IN RANGE  ${result}
    ${response_json_name}   Convert To String    ${response_patch_request.json()[${i}]["name"]}
    Log To Console    : ${response_json_name}

    IF  '${string_name}'=='${response_json_name}'
    ${response_json_id}   Convert To String    ${response_patch_request.json()[${i}]["id"]}
    Log To Console    Id de '${response_json_name}': ${response_json_id}
    END
  END

  [return]  ${response_json_id}

  # Log To Console    ${response_json}

# POST
Create a Board
  [arguments]   ${api_key}  ${token_trello}  ${board_name}

  ${response_patch_request}     Post Request    ${alias}    /1/boards/?name=${board_name}&defaultLists=false&key=${api_key}&token=${token_trello}

  Validate Response Status Code    ${response_patch_request.status_code}    200

Create a List
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name}

  ${board_id}  Get Board Id By board Name    ${api_key}  ${token_trello}  ${board_name}

  ${response_patch_request}     Post Request    ${alias}    /1/lists?key=${api_key}&token=${token_trello}&name=${list_name}&idBoard=${board_id}

  Validate Response Status Code    ${response_patch_request.status_code}    200

Create a Card
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name}  ${card_name}

  ${list_id}  Get Id List on a Board    ${api_key}  ${token_trello}  ${board_name}    ${list_name}

  ${response_patch_request}     Post Request    ${alias}    /1/cards?key=${api_key}&token=${token_trello}&name=${card_name}&idList=${list_id}

  Validate Response Status Code    ${response_patch_request.status_code}    200

# PUT
Change Card Position on List
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name_initial}  ${list_name_ending}  ${card_name}

  ${card_id}  Get Card Id in a List  ${api_key}  ${token_trello}  ${board_name}  ${list_name_initial}  ${card_name}
  ${list_id_ending}  Get Id List on a Board    ${api_key}  ${token_trello}  ${board_name}    ${list_name_ending}

  # ${body}       Get File     ${EXECDIR}/resources/card_change.json
  # ${body}      Convert To String    ${body}
  #
  # ${body}    Replace String Using Regexp    ${body}    _id    ${card_id}

  # ${header}       Create Dictionary   Content-Type=application/x-www-form-urlencoded; charset=UTF-8
  ${response_patch_request}     Put Request    ${alias}    /1/cards/${card_id}/idList/?value=${list_id_ending}&key=${api_key}&token=${token_trello}
  # ...               data=${body}
  # ...               headers=${header}

  Validate Response Status Code    ${response_patch_request.status_code}    200

# DELETE
Delete a Board
  [arguments]   ${api_key}  ${token_trello}  ${board_name}

  ${board_id}  Get Board Id By board Name    ${api_key}  ${token_trello}  ${board_name}

  ${response_patch_request}     Delete Request    ${alias}    /1/boards/${board_id}?key=${api_key}&token=${token_trello}

  Validate Response Status Code    ${response_patch_request.status_code}    200

Delete a Card
  [arguments]   ${api_key}  ${token_trello}  ${board_name}  ${list_name}  ${card_name}

  ${card_id}  Get Card Id in a List  ${api_key}  ${token_trello}  ${board_name}  ${list_name}  ${card_name}

  ${response_patch_request}     Delete Request    ${alias}    /1/cards/${card_id}?key=${api_key}&token=${token_trello}

  Validate Response Status Code    ${response_patch_request.status_code}    200

# Validate
Validate Response Status Code
  [Arguments]         ${status_code_read}  ${status_code_ok}
  ${status_code}      Convert to String       ${status_code_read}
  Should be equal     ${status_code_ok}       ${status_code}
