*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String


*** Variables ***


*** Keywords ***
Criar Board
  [arguments]   ${api_key}      ${token_trello}      ${board_name}     ${resultado_esperado}
  
  ${response}     POST On Session    alias=trello    url=/1/boards/?name=${board_name}&key=${api_key}&token=${token_trello}  
  ...    expected_status=${resultado_esperado}    data={"defaultLists":false}

  ${board_id}    Set Variable    ${response.json()['id']}

  [Return]    ${board_id}

Listar Board por ID
  [arguments]   ${api_key}      ${token_trello}      ${board_id}     ${resultado_esperado}

  ${response}     GET On Session    alias=trello    url=/1/boards/${board_id}?key=${api_key}&token=${token_trello}  
  ...    expected_status=${resultado_esperado}

  Log To Console   ${response.text}

Editar Board
  [arguments]   ${api_key}  ${token_trello}      ${board_id}    ${novo_nome}    ${resultado_esperado}

  ${response}     PUT On Session   alias=trello    url=/1/boards/${board_id}?key=${api_key}&token=${token_trello}
  ...       expected_status=${resultado_esperado}    data={"name": "${novo_nome}"}
  
  Log To Console    ${response.json()['name']}    
                                                          
Deletar Board
  [arguments]   ${api_key}  ${token_trello}      ${board_id}    ${resultado_esperado}

  ${response}     DELETE On Session   alias=trello    url=/1/boards/${board_id}?key=${api_key}&token=${token_trello}    expected_status=${resultado_esperado}
                                                          