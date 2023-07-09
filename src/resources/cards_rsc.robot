*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String

*** Variables ***


*** Keywords ***
Criar Card
  [arguments]   ${api_key}      ${token_trello}      ${list_id}    ${card_name}     ${resultado_esperado}
  
  ${response}     POST On Session    alias=trello    url=/1/cards?idList=${list_id}&key=${api_key}&token=${token_trello} 
  ...    expected_status=${resultado_esperado}    data={"name":"${card_name}"}

  ${card_id}    Set Variable    ${response.json()['id']}

  [Return]    ${card_id}

Listar Card por ID
  [arguments]   ${api_key}      ${token_trello}      ${card_id}     ${resultado_esperado}

  ${response}     GET On Session    alias=trello    url=/1/cards/${card_id}?key=${api_key}&token=${token_trello}
  ...    expected_status=${resultado_esperado}
  
  Log To Console   ${response.text}

Mover Card
  [arguments]   ${api_key}  ${token_trello}      ${card_id}    ${list_destino}    ${resultado_esperado}

  ${response}     PUT On Session   alias=trello    url=/1/cards/${card_id}?key=${api_key}&token=${token_trello}
  ...       expected_status=${resultado_esperado}    data={"idList": "${list_destino}"}
  
  # Log To Console    ${response.json()['name']}    

Validar Posição do Card
  [arguments]   ${api_key}      ${token_trello}      ${card_id}    ${list_id}     ${resultado_esperado}

  ${response}     GET On Session    alias=trello    url=/1/cards/${card_id}?key=${api_key}&token=${token_trello}
  ...    expected_status=${resultado_esperado}

  ${current_list}    Set Variable      ${response.json()['idList']}

  Should Be Equal    ${current_list}    ${list_id}


Deletar Card
  [arguments]   ${api_key}  ${token_trello}      ${card_id}    ${resultado_esperado}

  ${response}     DELETE On Session   alias=trello    url=/1/cards/${card_id}?key=${api_key}&token=${token_trello}    expected_status=${resultado_esperado}
                                                          