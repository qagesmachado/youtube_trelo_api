*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String


*** Variables ***


*** Keywords ***
Criar Lists
  [arguments]   ${api_key}      ${token_trello}      ${board_id}    ${name_list}     ${resultado_esperado}
  
  ${response}     POST On Session    alias=trello    url=1/lists?idBoard=${board_id}&key=${api_key}&token=${token_trello}  
  ...    expected_status=${resultado_esperado}    data={"name":"${name_list}"}

  ${list_id}    Set Variable    ${response.json()['id']}

  [Return]    ${list_id}

Ler Lists
  [arguments]   ${api_key}      ${token_trello}      ${list_id}     ${resultado_esperado}

  ${response}     GET On Session    alias=trello    url=1/lists/${list_id}?key=${api_key}&token=${token_trello}
  ...    expected_status=${resultado_esperado}

  Log To Console   ${response.json()}
